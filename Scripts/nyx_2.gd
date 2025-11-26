extends CharacterBody2D

signal doble_salto_ejecutado

const SPEED = 180.0
const JUMP_VELOCITY = -365.0
const DOUBLE_JUMP_VELOCITY = -290.0
var CLIMB_SPEED = 120.0

@onready var sprite_2d = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.2
var jump_count = 0
const MAX_JUMPS = 2
var is_climbing = false
var is_dead = false
var can_climb = false  

func _physics_process(delta):
	if is_dead:
		return
	
	if can_climb and (Input.is_action_pressed("ToClimb") or Input.is_action_pressed("Down")):
		is_climbing = true
	elif not can_climb:
		is_climbing = false
	
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	
	if is_climbing:
		velocity.y = 0
		
		if Input.is_action_pressed("ToClimb"):
			velocity.y = -CLIMB_SPEED
		elif Input.is_action_pressed("Down"):
			velocity.y = CLIMB_SPEED
		
		sprite_2d.animation = "Climb"
		
		if Input.is_action_just_pressed("Jump"):
			is_climbing = false
			velocity.y = JUMP_VELOCITY
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
			if velocity.y < 0:
				sprite_2d.animation = "Jump"
			else:
				sprite_2d.animation = "Fall"
		else:
			jump_count = 0
			if abs(velocity.x) > 1:
				sprite_2d.animation = "Run"
			else:
				sprite_2d.animation = "Idle"
		
		# Saltos
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_count += 1
		elif Input.is_action_just_pressed("Jump") and jump_count < MAX_JUMPS and not is_on_floor():
			velocity.y = DOUBLE_JUMP_VELOCITY
			jump_count += 1
			emit_signal("doble_salto_ejecutado")
	
	move_and_slide()
	sprite_2d.flip_h = velocity.x < 0

func die():
	is_dead = true
	velocity = Vector2.ZERO
	sprite_2d.animation = "Dead"
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

func _on_spikes_body_entered(body: Node2D) -> void:
	if body == self:
		die()

func set_climb_speed(value: float) -> void:
	CLIMB_SPEED = value

func enter_ladder():
	can_climb = true
	print("Puede escalar")

func exit_ladder():
	can_climb = false
	is_climbing = false
	print("No puede escalar")
