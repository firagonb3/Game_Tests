extends Node2D
# This is a hacky way of doing animation
# I do not advise you using this in real projects
# Instead learn how to use a STATE MACHINE
# https://www.youtube.com/results?search_query=godot+state+machine
# Choose a video of your liking

export var player_path : NodePath
onready var Player := get_node(player_path)

onready var animate := $animate

onready var jump := $Jump
onready var idle := $Idle
onready var run := $Run

var previous_frame_velocity := Vector2(0,0)


# Avoid errors
func _ready() -> void:
	if Player == null:
		print("Sprite.gd is missing player_path")
		set_process(false)


func _process(_delta: float) -> void:
	
	if (Input.is_action_pressed("jump")):
		_jump()
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		jump.hide()
		run.show()
		idle.hide()
		animate.play("run")
	else:
		jump.hide()
		run.hide()
		idle.show()
		animate.play("idle")

func _jump():
	if previous_frame_velocity.y >= 0 and Player.velocity.y < 0:
		jump.show()
		idle.hide()
		run.hide()
		animate.play("Jump")
	elif previous_frame_velocity.y > 0 and Player.is_on_floor():
		
		idle.show()
		animate.play("idle")
	
	# It's important that this is the last thing done
	previous_frame_velocity = Player.velocity