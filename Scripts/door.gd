extends StaticBody2D

var is_locked = true

func _ready():
	$CollisionShape2D.disabled = false

func unlock():
	is_locked = false
	$Sprite2D.texture = preload("res://Assets/Items/Door_Open.png")
	collision_layer = 0
	collision_mask = 0
	print("Puerta desbloqueada")

func lock():
	is_locked = true
	$Sprite2D.texture = preload("res://Assets/Items/Door_Close.png")
	collision_layer = 1
	collision_mask = 1
	print("Puerta bloqueada")

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name == "Nyx2":
		if is_locked:
			print("La puerta está cerrada. Necesitas una llave.")
		else:
			print("La puerta está abierta")
