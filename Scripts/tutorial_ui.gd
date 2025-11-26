extends CanvasLayer

@onready var jump_panel = $Tutorial_Container/Jump_Panel
@onready var double_jump_panel = $Tutorial_Container/Double_Jump_Panel
@onready var movement_panel = $Tutorial_Container/Movement_Panel

@onready var player = get_parent().get_node("Nyx")
@onready var arrow_area = get_parent().get_node("Area2D")  

var jump_completed = false
var double_jump_completed = false
var movement_completed = false

var moved_left = false
var moved_right = false

var normal_modulate = Color(1, 1, 1, 1)  
var glow_modulate = Color(2, 2, 1.5, 1)  

var previous_jump_count = 0

func _ready():
	jump_panel.modulate = normal_modulate
	double_jump_panel.modulate = normal_modulate
	movement_panel.modulate = normal_modulate
	
	arrow_area.visible = false 
	
	if player.has_signal("doble_salto_ejecutado"):
		player.doble_salto_ejecutado.connect(_on_double_jump)

func _process(_delta):
	if player.is_on_floor() and previous_jump_count == 1 and not jump_completed:
		activate_glow(jump_panel)
		jump_completed = true
	
	if not player.is_on_floor():
		previous_jump_count = player.jump_count
	
	if player.is_on_floor():
		previous_jump_count = 0
	
	var direction = Input.get_axis("Left", "Right")
	if direction < 0:  
		moved_left = true
	elif direction > 0: 
		moved_right = true

	if moved_left and moved_right and not movement_completed:
		activate_glow(movement_panel)
		movement_completed = true

	if jump_completed and double_jump_completed and movement_completed:
		arrow_area.visible = true

func _on_double_jump():
	if not double_jump_completed:
		activate_glow(double_jump_panel)
		double_jump_completed = true

func activate_glow(panel):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(panel, "modulate", glow_modulate, 0.3)
	tween.tween_property(panel, "modulate", normal_modulate, 0.3)
	tween.tween_property(panel, "modulate", glow_modulate, 0.3)
	tween.tween_property(panel, "modulate", normal_modulate, 0.3)
	
	tween.tween_property(panel, "modulate", Color(1.3, 1.3, 1.1, 1), 0.2)
