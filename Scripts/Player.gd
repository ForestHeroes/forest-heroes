extends Node2D

var status

func _ready():
	status = get_node("Attributes")
	print(status.DMG)
	pass