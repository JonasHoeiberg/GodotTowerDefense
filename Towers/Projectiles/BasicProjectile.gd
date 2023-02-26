extends Area2D

# Should projectiles be assemblies as well?

signal hit

var speed = 1000
var damage = 20
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

func get_class(): return "Projectile"
