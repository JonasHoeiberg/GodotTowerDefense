extends Area2D

signal target_changed

var currentTarget: Node2D
var potentialTargets = []

func _on_MobTargeter_area_entered(area: Area2D):
	var newTarget = area
	newTarget.position = area.position
	
	potentialTargets.append(newTarget)
	
	if currentTarget != null:
		return
		
	currentTarget = newTarget
	
	emit_signal("target_changed", currentTarget)

func _on_MobTargeter_area_exited(area: Area2D):
	potentialTargets.pop_at(
		potentialTargets.find(area)
	)
	
	if potentialTargets.size() == 0:
		emit_signal("target_changed", null)
		return
	
	currentTarget = potentialTargets[0]
	
	emit_signal("target_changed", currentTarget)
