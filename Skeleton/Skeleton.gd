extends KinematicBody2D

const FLOOR = Vector2(0,-1)
const GRAVITY  = 25.0
const SPEED  = 800

onready var PAUSE2 = 1000
const START = 500

onready var motion : Vector2 = Vector2.ZERO
onready var can_move : bool = true
onready var direction : int = 1

onready var idle := $sprite/idle
onready var Walk := $sprite/Walk
onready var Attack := $sprite/Attack
onready var animation := $sprite/animation

onready var detecter_player := $raycast/detecter_player
onready var detecter_attak := false

onready var max_heal := 2

onready var pause := 0
onready var start := 0

func _ready():
	animation.play("walk")
	pass 

func _process(_delta):
	if detecter_player.is_colliding():
		can_move = false
		detecter_attak = true
		idle.hide()
		Walk.hide()
		Attack.show()
		animation.play("Attack")
	elif detecter_attak:
		detecter_attak = false
		can_move = true
		Attack.hide()
		idle.hide()
		Walk.show()
		pause = 0
		start = 0
		animation.play("walk")
		
	if can_move:
		motion_ctrl()
	else:
		start += 1
		if (start == START):
			idle.hide()
			Walk.show()
			start = 0
			pause = 0
			can_move = true
			animation.play("walk")
	

func motion_ctrl() -> void:
	pause += 1
	if (pause == PAUSE2):
		idle.show()
		Walk.hide()
		animation.play("idle")
		can_move = false
	
	if direction == 1:
		idle.flip_h = false
		Walk.flip_h = false
		Attack.flip_h = false
	else:
		idle.flip_h = true
		Walk.flip_h = true
		Attack.flip_h = true
	
	if is_on_wall():
		direction *= -1
		$raycast.scale.x *= -1
	
	motion.y += GRAVITY
	motion.x = SPEED * direction
	
	motion = move_and_slide(motion, FLOOR)
