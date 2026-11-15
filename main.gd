extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D
@onready var score_label = $CanvasLayer/Label

var platform_scene = preload("res://platform.tscn")
var highest_spawn_y = 600.0
var start_y = 600.0
var score = 0

func _ready():
	# Spawn the first batch of platforms
	for i in range(12):
		spawn_platform()

func _process(_delta):
	# Move camera up only when player reaches a new height
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y
		score = int((start_y - camera.position.y) / 10)
		score_label.text = "Score: " + str(score)

	# Keep spawning platforms ahead of the camera
	while highest_spawn_y > camera.position.y - 600:
		spawn_platform()

func spawn_platform():
	var plat = platform_scene.instantiate()
	var random_x = randf_range(60, 420)
	plat.position = Vector2(random_x, highest_spawn_y)
	add_child(plat)
	# Move the next spawn point up by a reachable distance
	highest_spawn_y -= randf_range(90, 150)

func _on_area_2d_body_entered(body):
	# Restart the game if the player falls below the camera
	if body == player:
		get_tree().reload_current_scene()
	# Delete old platforms to save memory
	elif body is StaticBody2D:
		body.queue_free()
