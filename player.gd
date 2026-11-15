extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -700.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Bounce automatically when landing on a platform
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("default")

	# Move left and right using Arrow Keys or A/D
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	move_and_slide()

	# Wrap around screen edges
	var screen_width = get_viewport_rect().size.x
	position.x = wrapf(position.x, 0, screen_width)
