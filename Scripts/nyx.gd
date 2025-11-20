extends CharacterBody2D


signal doble_salto_ejecutado 

const SPEED = 250.0 
const JUMP_VELOCITY = -450.0  
const DOUBLE_JUMP_VELOCITY = -400.0 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
var jump_count = 0
const MAX_JUMPS = 2

@onready var animated_sprite = $AnimatedSprite2D 

func _physics_process(delta):
	var velocity = self.velocity

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jump_count = 0 
	
	if Input.is_action_just_pressed("Jump"): 
		
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			
		elif jump_count < MAX_JUMPS:
			velocity.y = DOUBLE_JUMP_VELOCITY
			jump_count += 1
			
			emit_signal("doble_salto_ejecutado")

	var direction = Input.get_axis("Left", "Right") 
	
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
		animated_sprite.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 4 * delta)
		if is_on_floor():
			animated_sprite.play("Idle")

	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("Jump") 
		else:
			animated_sprite.play("Fall") 

	self.velocity = velocity
	move_and_slide()
