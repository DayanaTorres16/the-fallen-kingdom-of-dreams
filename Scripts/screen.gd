extends Node2D
var ui_node: Node

func _ready():
	ui_node = get_node("/root/Ui")
	ui_node.hide()

func _exit_tree():
	ui_node.show()
		
