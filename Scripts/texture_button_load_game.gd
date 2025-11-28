extends TextureButton

func _on_load_game_pressed():
	var save_path = "user://save_game.dat"
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		var game_data = save_file.get_var()
		save_file = null
		
		var scene_path = game_data.get("scene", "")
		if scene_path != "":
			get_tree().change_scene_to_file(scene_path)
		else:
			print("No hay escena guardada")
