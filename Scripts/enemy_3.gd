extends CharacterBody2D

const SPEED = 100.0
const GRAVITY = 980

func _ready():
	velocity.x = SPEED
	$AnimatedSprite2D.play("Walk")

func _next_to_left_wall() -> bool:
	return $Left.is_colliding()

func _next_to_right_wall() -> bool:
	return $Right.is_colliding()

func flip():
	if _next_to_left_wall() or _next_to_right_wall():
		velocity.x *= -1
		$AnimatedSprite2D.scale.x *= -1

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	flip()
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D):
	if body.has_method("die"):
		body.die()
