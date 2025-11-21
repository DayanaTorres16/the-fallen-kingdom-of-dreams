extends CanvasLayer

@onready var jump_panel = $Tutorial_Container/Jump_Panel
@onready var double_jump_panel = $Tutorial_Container/Double_Jump_Panel
@onready var movement_panel = $Tutorial_Container/Movement_Panel

# Referencias al personaje (ajusta la ruta según tu escena)
@onready var player = get_parent().get_node("Nyx")

# Variables para rastrear acciones completadas
var jump_completed = false
var double_jump_completed = false
var movement_completed = false

# Variables para detectar movimiento bidireccional
var moved_left = false
var moved_right = false

# Colores para el efecto de brillo
var normal_modulate = Color(1, 1, 1, 1)  # Color normal
var glow_modulate = Color(2, 2, 1.5, 1)  # Color brillante (más luminoso)

# Variable para rastrear el jump_count previo
var previous_jump_count = 0

func _ready():
	# Asegurar que todos los paneles empiecen sin brillo
	jump_panel.modulate = normal_modulate
	double_jump_panel.modulate = normal_modulate
	movement_panel.modulate = normal_modulate
	
	# Conectar señal del doble salto si existe
	if player.has_signal("doble_salto_ejecutado"):
		player.doble_salto_ejecutado.connect(_on_double_jump)

func _process(_delta):
	# Detectar salto simple (solo cuando salta una vez y vuelve al suelo)
	if player.is_on_floor() and previous_jump_count == 1 and not jump_completed:
		activate_glow(jump_panel)
		jump_completed = true
	
	# Guardar el jump_count cuando el jugador está en el aire
	if not player.is_on_floor():
		previous_jump_count = player.jump_count
	
	# Resetear el contador cuando toca el suelo nuevamente
	if player.is_on_floor():
		previous_jump_count = 0
	
	# Detectar movimiento izquierda/derecha
	var direction = Input.get_axis("Left", "Right")
	if direction < 0:  # Moviéndose a la izquierda
		moved_left = true
	elif direction > 0:  # Moviéndose a la derecha
		moved_right = true
	
	# Brillar cuando se haya movido en ambas direcciones
	if moved_left and moved_right and not movement_completed:
		activate_glow(movement_panel)
		movement_completed = true

func _on_double_jump():
	# Esta función se llama cuando se ejecuta el doble salto
	if not double_jump_completed:
		activate_glow(double_jump_panel)
		double_jump_completed = true

func activate_glow(panel):
	# Crear efecto de brillo con animación
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	# Animar el brillo: normal -> brillante -> normal (pulso)
	tween.tween_property(panel, "modulate", glow_modulate, 0.3)
	tween.tween_property(panel, "modulate", normal_modulate, 0.3)
	tween.tween_property(panel, "modulate", glow_modulate, 0.3)
	tween.tween_property(panel, "modulate", normal_modulate, 0.3)
	
	# Mantener un brillo suave permanente
	tween.tween_property(panel, "modulate", Color(1.3, 1.3, 1.1, 1), 0.2)
