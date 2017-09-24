extends KinematicBody2D

onready var attributes = get_node("Attributes")
onready var tween = get_node("Tween")

const IDLE_SPEED = 10.0

var current_anim = ""

var speed = Vector2()
var dodge_cd = 1

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	move_player(delta)
	animate()

func move_player(delta):
	
	var dir = Vector2()
	if (Input.is_action_pressed("ui_up")):
		dir += Vector2(0, -1)
	if (Input.is_action_pressed("ui_down")):
		dir += Vector2(0, 1)
	if (Input.is_action_pressed("ui_left")):
		dir += Vector2(-1, 0)
	if (Input.is_action_pressed("ui_right")):
		dir += Vector2(1, 0)
		
	if(Input.is_action_pressed("dodge") and dodge_cd >= 1):
		dodge(get_pos(),dir.normalized())
		yield( tween,"tween_complete")
		dodge_cd = 0
	dodge_cd += delta
	
	speed = dir.normalized() * attributes.MSPD * delta
	
	var motion = move(speed)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		move(motion)

func dodge(start_pos,direction):
	var distance = 100
	var time = 0.2
	var end_pos = start_pos + (direction * distance)
	tween.interpolate_property(self,"transform/pos",
	start_pos,
	end_pos,
	time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func animate():
	var next_anim = ""
	var next_mirror = false
	
	if (speed.length() < IDLE_SPEED):
		next_anim = "idle"
	elif (speed.length() > IDLE_SPEED*0.1):
		var angle = atan2(abs(speed.x), speed.y)
		
		next_mirror = speed.x > 0
		if (angle < PI/8):
			next_anim = "bottom"
		elif (angle < PI/4 + PI/8):
			next_anim = "bottom_left"
		elif (angle < PI*2/4 + PI/8):
			next_anim = "left"
		elif (angle < PI*3/4 + PI/8):
			next_anim = "top_left"
		else:
			next_anim = "top"
	
	if (next_anim != current_anim):
		#get_node("Anim").play(next_anim)
		current_anim = next_anim
	

func _on_Area2D_body_enter( body ):
	tween.stop(self,"transform/pos")
