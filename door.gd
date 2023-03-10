extends Area2D

export var MAX_COUNT := 6

var open := true

func _ready():
	pass


func _on_door_body_entered(body):
	if "Player" in body.name:
		if body.count == MAX_COUNT and open == true:
			open = false
			$Animation.play("Open")
	pass 
