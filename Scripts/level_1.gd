extends Node2D

func _on_key_body_entered(body: Node2D) -> void:
	if body.name == "Nyx2":
		$Door.unlock()
		$Key.call_deferred("queue_free")
