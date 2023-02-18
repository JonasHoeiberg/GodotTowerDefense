extends Node2D

var direction = Vector2(1,0)

func aim_at(mouse_position: Vector2):
	$Canon.look_at(mouse_position)
	direction = mouse_position - global_position
	direction = direction.normalized()

func get_tip():
	return position + (direction * $Canon/Barrel.scale.x * scale.x * 2)
