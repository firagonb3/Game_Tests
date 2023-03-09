extends Control

onready var Player := get_node("../../../../Player")

func _ready():
	pass

	
func _process(delta):
	if Player.max_heal < 3:
		$gui/heat3.frame = 2
		
	if Player.max_heal < 2:
		$gui/heat2.frame = 2
	
	if Player.max_heal < 1:
		$gui/heat.frame = 2
	pass
