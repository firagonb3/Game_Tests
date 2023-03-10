extends KinematicBody2D

const FLOOR = Vector2(0,-1)
const GRAVITY  = 25.0
const SPEED  = 800

export var PAUSE2 = 1000
const START = 500

onready var motion : Vector2 = Vector2.ZERO
onready var can_move : bool = true
export var direction : int = 1

onready var idle := $sprite/idle
onready var Walk := $sprite/Walk
onready var Attack := $sprite/Attack
onready var Death := $sprite/Death

onready var animation := $sprite/animation

onready var hit := $raycast/detecter_hit

onready var detecter_player := $raycast/detecter_player
onready var detecter_attak := false

onready var hitolayer := $player/hitPlayer

onready var player

onready var pause := 0
onready var start := 0

var max_heal := 1
var deah = false

func damage():
	max_heal -= 1
	if max_heal < 0:
		player.count += 1
		deah = true
		idle.hide()
		Walk.hide()
		Attack.hide()
		Death.show()
		animation.play("death")

func _ready():
	$raycast.scale.x = direction
	animation.play("walk")
	pass

func _process(_delta):
	
	if deah == false:
		if hit.is_colliding():
			#hit_detectet = true
			player.damag()
		
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
		Death.flip_h = false
	else:
		idle.flip_h = true
		Walk.flip_h = true
		Attack.flip_h = true
		Death.flip_h = true
	
	if is_on_wall():
		direction *= -1
		$raycast.scale.x = direction
		
	motion.y += GRAVITY
	motion.x = SPEED * direction
	motion = move_and_slide(motion, FLOOR)


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		player = body 
		
		
func _on_player_area_entered(area):
	print(area.is_in_group("attack"))
	if area.is_in_group("attack") and deah == false:
		damage()
	pass # Replace with function body.
