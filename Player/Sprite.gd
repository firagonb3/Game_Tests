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
onready var death := $Death

onready var Attack := $Attack

onready var animation_ctrl := true

# Avoid errors
func _ready() -> void:
	print(Player)
	if Player == null:
		print("Sprite.gd is missing player_path")
		set_process(false)


func _process(_delta: float) -> void:
	if Player.deah == false:
		if Player.detected_hit == false:
			if Input.is_action_pressed("ui_accept"):
				animation_ctrl = false
				jump.hide()
				run.hide()
				idle.hide()
				Attack.show()
				animate.play("Attack")
			else: 
				animation_ctrl = true
				
			if animation_ctrl:
				animate_ctrl()

func animate_ctrl() -> void: 
	if Input.is_action_pressed("jump") and !Player.is_on_floor():
		jump.show()
		idle.hide()
		run.hide()
		Attack.hide()
		animate.play("Jump")
	elif (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")) and Player.is_on_floor():
		jump.hide()
		run.show()
		idle.hide()
		Attack.hide()
		animate.play("run")
	elif Player.is_on_floor():
		jump.hide()
		run.hide()
		idle.show()
		Attack.hide()
		animate.play("idle")
