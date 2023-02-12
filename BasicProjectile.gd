extends Area2D

signal hit

var speed = 50
var direction = Vector2(1, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	position += direction * speed * delta

func hit():
	emit_signal('hit')
	queue_free()
	
	

func _on_BasicProjectile_area_entered(area):
	hit()
