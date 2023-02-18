extends Timer

signal fired



func _on_TimedFireControl_timeout():
	emit_signal("fired")
