extends StaticBody2D

var speed = 50
var direction = Vector2(1, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	position += direction * speed * delta
	print(position)
