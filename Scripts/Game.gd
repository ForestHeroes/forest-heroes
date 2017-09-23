extends Node2D

onready var player = get_node("Player")

func _ready():
	set_process(true)
	pass

func _process(delta):
	