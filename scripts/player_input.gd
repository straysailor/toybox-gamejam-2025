extends CharacterBody2D

@export var climb_speed : int = 0
@export var facing : String = "left"

const SPEED = 700.0
const JUMP_VELOCITY = -600.0

@onready var sprites = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2 

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY - climb_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction == 1:
			facing = "right"
		else:
			facing = "left"
			
		if facing == "right":
			sprites.flip_h = true
		else:
			sprites.flip_h = false
			
		sprites.play("walk")
			
		velocity.x = direction * SPEED
	else:
		if facing == "right":
			sprites.flip_h = true
		sprites.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
