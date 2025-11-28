extends Node

var points_label
var puntos = 0

var save_path = "user://save_game.dat"
var current_scene_path: String = ""  

var game_data: Dictionary = {
	"puntos": puntos,
	"scene": current_scene_path
}

func _ready():
	points_label = get_node_or_null("/root/Ui/Panel/PointsLabel")
	update_ui()

func add_puntos() -> void:
	puntos += 1
	update_ui()

func update_ui():
	if points_label:
		points_label.text = str(puntos)

func saveGame() -> void:
	game_data["puntos"] = puntos
	game_data["scene"] = get_tree().current_scene.get_scene_file_path()  
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	save_file.store_var(game_data)
	save_file = null
	print("Game saved")

func loadGame() -> void:
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		game_data = save_file.get_var()
		save_file = null
		
		puntos = game_data.get("puntos", 0)
		current_scene_path = game_data.get("scene", "")
		update_ui()
		
		print("Game loaded")
		print(game_data)
		
		if current_scene_path != "":
			get_tree().change_scene_to_file(current_scene_path)
		else:
			print("No hay escena guardada")
