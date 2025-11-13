extends Control

const NEXT_SCENE_PATH = "res://Scenes/main_menu.tscn"

func _ready():
	set_process_input(true)
	$AnimationPlayer.play("Parpadeo")
	print("Pantalla de Inicio Activa. Esperando input...")

func _input(event):
	if event is InputEvent and event.is_pressed():
		if not (event is InputEventKey and event.is_echo()):
			change_scene_to_menu()

func change_scene_to_menu():
	set_process_input(false)
	
	$AnimationPlayer.stop()
	
	print("Input detectado. Cambiando a Main Menu...")
	
	var error = get_tree().change_scene_to_file(NEXT_SCENE_PATH)
	
	if error != OK:
		print("ERROR: No se pudo cargar la escena: ", NEXT_SCENE_PATH, ". Código de error: ", error)
