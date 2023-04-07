extends Node2D

export (PackedScene) var ModelType

export (int) var health = 40
export (float) var speed = 100

# We can't inject this as an export, as it requires knowledge of the board
# Maybe we can have a control type and map it?
# Maybe think about this architecture. What if we want an effect that causes mobs to run? How do we
# handle the dependencies here
var controller
var model

# Called when the node enters the scene tree for the first time.
func _ready():
	model = ModelType.instance()
	model.connect("hit", self, "onHit")
	add_child(model)

func _process(delta):
	if controller == null:
		return
		
	position += controller.resolveDirection(position) * delta * speed

func setController(control):
	controller = control
	add_child(control)

func onHit(other):
	match other.get_class():
		"Mob":
			pass
		"Projectile":
			projectileHit(other)
			
func projectileHit(projectile):
	health -= projectile.damage
	# TODO: Emit signal, parent should handle side effects
	if health <= 0:
		queue_free()

func get_class(): return "Mob"
