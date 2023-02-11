extends Node2D

var direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func aim_at(global_position: Vector2):
	$Canon.look_at(global_position)
	# TODO: Figure out why the Tip doesn't seem to care about transformations of parent
	direction = global_position - position
	direction = direction.normalized()
