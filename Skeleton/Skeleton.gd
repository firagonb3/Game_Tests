extends KinematicBody2D

const FLOOR = Vector2(0,-1)
const GRAVITY  = 25.0
const SPEED  = 800

const PAUSE = 1000
const START = 500

onready var motion : Vector2 = Vector2.ZERO
onready var can_move : bool = true
onready var direction : int = 1

onready var pause := 0
onready var start := 0

func _ready():
	$sprite/animation.play("walk")
	pass 

func _process(_delta):
	if can_move:
		motion_ctrl()
	else:
		start += 1
		if (start == START):
			$sprite/idle.hide()
			$sprite/Walk.show()
			$sprite/animation.play("walk")
			start = 0
			pause = 0
			can_move = true
		

func motion_ctrl() -> void:
	pause += 1
	if (pause == PAUSE):
		$sprite/idle.show()
		$sprite/Walk.hide()
		$sprite/animation.play("idle")
		can_move = false
	
	if direction == 1:
		$sprite/idle.flip_h = false
		$sprite/Walk.flip_h = false
	else:
		$sprite/idle.flip_h = true
		$sprite/Walk.flip_h = true
	
	if is_on_wall():
		direction *= -1
		$raycast.scale.x *= -1
	
	motion.y += GRAVITY
	motion.x = SPEED * direction
	
	motion = move_and_slide(motion, FLOOR)
