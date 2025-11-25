extends CharacterBody2D

signal doble_salto_ejecutado

const SPEED = 180.0
const JUMP_VELOCITY = -365.0
const DOUBLE_JUMP_VELOCITY = -290.0
const CLIMB_SPEED = 120.0

@onready var sprite_2d = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.2
var jump_count = 0
const MAX_JUMPS = 2

var is_climbing = false
var is_dead = false

func _physics_process(delta):
	if is_dead:
		return  # si está muerto, no procesa movimiento

	# Movimiento horizontal
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	# Escalada
	if is_climbing:
		if Input.is_action_pressed("ToClimb"):
			velocity.y = -CLIMB_SPEED
		elif Input.is_action_pressed("Down"):
			velocity.y = CLIMB_SPEED
		else:
			velocity.y = 0
		sprite_2d.animation = "Climb"
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

		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_count += 1
		elif Input.is_action_just_pressed("Jump") and jump_count < MAX_JUMPS and not is_on_floor():
			velocity.y = DOUBLE_JUMP_VELOCITY
			jump_count += 1
			emit_signal("doble_salto_ejecutado")

	move_and_slide()
	sprite_2d.flip_h = velocity.x < 0

# 🚨 Función de muerte
func die():
	is_dead = true
	velocity = Vector2.ZERO
	sprite_2d.animation = "Dead"
	await get_tree().create_timer(1.0).timeout  # espera 1 segundo
	get_tree().reload_current_scene()

# Señales de escalera
func _on_ladder_body_entered(body: Node2D) -> void:
	if body == self:
		is_climbing = true

func _on_ladder_body_exited(body: Node2D) -> void:
	if body == self:
		is_climbing = false

# Señal de púas
func _on_spikes_body_entered(body: Node2D) -> void:
	if body == self:
		die()
