extends Area2D

# Figure out if the hit detection should live in here, or by itself

signal hit

# TODO: Move this logic so the mob doesn't kill itself
func _on_Mob_area_entered(area):
	emit_signal("hit", area)
