extends Node2D

# TODO All these things that don't have physical properties should be pure scripts in stead, imported using preload

var target: Node2D

# If we need to consider speed in decision making, add it as param
func resolveDirection(position: Vector2):
	if target == null:
		return Vector2()
		
	return (target.position - position).normalized()
