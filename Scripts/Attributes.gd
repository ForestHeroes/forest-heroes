extends Node2D

export(float) var HP
export(float) var DMG
export(float) var DEF
export(float) var ASPD
export(float) var MSPD
export(float) var ATKRANGE

enum STATES{
	IDLE,
	DODGE
}

var current_state = STATES.IDLE