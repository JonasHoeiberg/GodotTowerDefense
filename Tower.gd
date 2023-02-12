extends Node2D

var direction = Vector2(1,0)

func aim_at(global_position: Vector2):
	$Canon.look_at(global_position)
	# TODO: Figure out why the Tip doesn't seem to care about transformations of parent
	direction = global_position - position
	direction = direction.normalized()

func get_tip():
	return position + (direction * $Canon/Barrel.scale.x * scale.x * 2)
