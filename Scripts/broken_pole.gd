extends StaticBody2D

var is_broken := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_broken:
		return
	if body.name == "Nyx2":
		is_broken = true
		# Cambia sprite a "palo completo" roto visualmente
		$Sprite2D.texture = preload("res://Assets/Items/Pole_Broken.png")
		# Espera 0.5 segundos antes de romper
		call_deferred("_schedule_break", body)

func _schedule_break(body: Node2D) -> void:
	await get_tree().create_timer(1.5).timeout  # medio segundo de espera
	$CollisionShape2D.disabled = true  # ahora sí se rompe
	if body.has_method("set_climb_speed"):
		body.set_climb_speed(220)
