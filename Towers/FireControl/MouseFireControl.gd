extends Node2D

signal fired

func _unhandled_input(event):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("fired")
