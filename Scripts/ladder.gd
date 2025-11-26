extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Nyx2":  # Cambia por el nombre exacto de tu personaje
		print("Nyx entró a la escalera")
		if body.has_method("enter_ladder"):
			body.enter_ladder()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Nyx2":
		print("Nyx salió de la escalera")
		if body.has_method("exit_ladder"):
			body.exit_ladder()
