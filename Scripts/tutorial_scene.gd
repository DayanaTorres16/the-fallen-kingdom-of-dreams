# Archivo: Tutorial_Scene.gd
extends Node2D

@onready var panel_movimiento = $Tutorial_UI/Tutorial_Container/Movement_Panel
@onready var panel_salto = $Tutorial_UI/Tutorial_Container/Jump_Panel
@onready var panel_doble_salto = $Tutorial_UI/Tutorial_Container/Double_Jump_Panel
@onready var nyx = $Nyx 

var movimiento_completado = false
var salto_completado = false
var doble_salto_completado = false

func _ready():
	panel_movimiento.visible = true
	panel_salto.visible = false 
	panel_doble_salto.visible = false
	
	nyx.connect("doble_salto_ejecutado", self, "on_doble_salto_ejecutado")


func _process(delta):
	if not movimiento_completado:
		if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
			movimiento_completado = true
			panel_movimiento.visible = false
			show_salto_tutorial()

func _physics_process(delta):
	if movimiento_completado and not salto_completado:
		if Input.is_action_just_pressed("Jump"):
			salto_completado = true
			panel_salto.visible = false
			
			show_doble_salto_tutorial()


func show_salto_tutorial():
	panel_salto.visible = true

func show_doble_salto_tutorial():
	panel_doble_salto.visible = true

func on_doble_salto_ejecutado():
	if not doble_salto_completado:
		doble_salto_completado = true
		panel_doble_salto.visible = false
		
		show_final_tutorial() 

func show_final_tutorial():
	print("¡TUTORIAL COMPLETADO! Avanza a la zona de salida.")
