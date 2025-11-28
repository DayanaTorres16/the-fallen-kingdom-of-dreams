extends Node2D

@onready var cherry = load("res://Scenes/collectible_gem.tscn")
@onready var timer = $Timer

var current_collectible: Node = null

func _ready():
	spawn()

func spawn():
	if current_collectible == null:
		var inst = cherry.instantiate()
		var x = randf_range(50, 1500)
		var y = randf_range(50, 300)   
		inst.position = Vector2(x, y)
		
		add_child(inst)  
		current_collectible = inst

		inst.connect("tree_exited", Callable(self, "_on_collectible_removed"))

func _on_collectible_removed():
	current_collectible = null
	timer.wait_time = randf_range(3, 5)
	timer.start()

func _on_timer_timeout():
	spawn()
