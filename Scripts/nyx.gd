extends CharacterBody2D

signal doble_salto_ejecutado 

const SPEED = 350.0 
const JUMP_VELOCITY = -365.0        
const DOUBLE_JUMP_VELOCITY = -290.0 

@onready var sprite_2d = $AnimatedSprite2D 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.2

var jump_count = 0
const MAX_JUMPS = 2

func _physics_process(delta):
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "Run"
	else:
		sprite_2d.animation = "Idle"
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0:
			sprite_2d.animation = "Jump"
		else:
			sprite_2d.animation = "Fall"
	else:
		jump_count = 0 
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	elif Input.is_action_just_pressed("Jump") and jump_count < MAX_JUMPS and not is_on_floor():
		velocity.y = DOUBLE_JUMP_VELOCITY
		jump_count += 1
		emit_signal("doble_salto_ejecutado")
	
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	
	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
