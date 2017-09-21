extends Node

var status = preload("Status.gd").new(5,1,2,3,4)

func _ready():
	print(status.atk)
	print(status.def)
	print(status.atkSpeed)
	print(status.movSpeed)
	print(status.atkRange)
	pass
