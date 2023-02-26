extends Area2D

signal target_changed

var currentTarget: Node2D
var potentialTargets = []

func _ready():
	setRange(400)

func _on_MobTargeter_area_entered(area: Area2D):
	var newTarget = area
	
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
		currentTarget = null
	else:
		currentTarget = potentialTargets[0]
	
	emit_signal("target_changed", currentTarget)

func setRange(rangeValue: float):
	$Range.shape.radius = rangeValue
