extends Area2D
var coins_audio

func _ready():
	coins_audio = get_node("/root/Ui/CoinsAudio")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Nyx2":
		SinglentonGameManager.add_puntos()  
		coins_audio.play()
		queue_free()
