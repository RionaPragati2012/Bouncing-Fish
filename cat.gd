extends CharacterBody2D

var speed = 60.0 # Low number = slow cat

func _physics_process(delta):
	var player = get_node("../Player")
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
