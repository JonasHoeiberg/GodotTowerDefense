extends Area2D

signal mob_hit
signal mob_dead


func kill():
	emit_signal("mob_dead")
	queue_free()


func _on_Mob_area_entered(area):
	emit_signal("mob_hit")
	kill()
	area.queue_free()
