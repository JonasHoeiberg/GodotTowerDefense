extends Node2D

signal target_changed

func _unhandled_input(event):
	if (event is InputEventMouseMotion):
		var target = Node2D.new()
		target.position = event.position
		emit_signal("target_changed", target)
