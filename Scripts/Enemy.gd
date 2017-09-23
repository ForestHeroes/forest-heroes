extends KinematicBody2D

onready var attributes = get_node("Attributes")
var chase = false
var player
	
func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if(chase == true):
		if(self.get_pos().distance_to(player.get_pos()) <= attributes.ATKRANGE):
			print()
		else:
			move_to_player(delta)

func move_to_player(delta):
	var dir = Vector2()
	if(player.get_pos().x < self.get_pos().x):
		dir += Vector2(-1,0)
	if(player.get_pos().x > self.get_pos().x):
		dir += Vector2(1,0)
	if(player.get_pos().y < self.get_pos().y):
		dir += Vector2(0,-1)
	if(player.get_pos().y > self.get_pos().y):
		dir += Vector2(0,1)
	
	var speed = dir.normalized() * attributes.MSPD
	var motion = speed*delta
	move(motion)

func _on_DetectArea_body_enter( body ):
	if(body.is_in_group("player")):
		player = body
		chase = true
