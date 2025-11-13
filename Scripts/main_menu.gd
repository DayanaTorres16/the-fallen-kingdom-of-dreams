extends Control

@onready var btn_new = $VBoxContainer/TextureButton_NewGame
@onready var btn_load = $VBoxContainer/TextureButton_LoadGame
@onready var btn_options = $VBoxContainer/TextureButton_Options
@onready var btn_quit = $VBoxContainer/TextureButton_Quit

func _ready():
	# Conectar las señales de los botones
	btn_new.pressed.connect(_on_nueva_partida_pressed)
	btn_load.pressed.connect(_on_cargar_partida_pressed)
	btn_options.pressed.connect(_on_opciones_pressed)
	btn_quit.pressed.connect(_on_quit_pressed)

func _on_nueva_partida_pressed():
	print("Iniciando nueva partida...")
	get_tree().change_scene_to_file("res://Scenes/Tutorial_Scene.tscn")

func _on_cargar_partida_pressed():
	print("Cargando partida...")

func _on_opciones_pressed():
	print("Abriendo opciones...")
	get_tree().change_scene_to_file("res://scenes/Options.tscn")

func _on_quit_pressed():
	print("Saliendo del juego...")
	get_tree().quit()
