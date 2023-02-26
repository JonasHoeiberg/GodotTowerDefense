extends Node2D

signal projectile_fired

export (PackedScene) var TowerModelType
export (PackedScene) var TargetingType
export (PackedScene) var ProjectileType
export (PackedScene) var FireControlType

var tower
var targeting

var currentTarget: Node2D

func _process(delta):
	if currentTarget == null:
		return
		
	tower.aim_at(currentTarget.global_position)

func _ready():
	initTower()
	initTargeting()
	initFireControl()
	
func initTower():
	tower = TowerModelType.instance()
	add_child(tower)
	

func initTargeting():
	targeting = TargetingType.instance()
	add_child(targeting)
	targeting.connect("target_changed", self, "setTarget")
	
# TODO: There's no reason for this to live here and be a packed scene. It should live in the tower implemenation
func initFireControl():
	var control = FireControlType.instance()
	add_child(control)
	control.connect("fired", self, "fireProjectile")
	
func setTarget(target: Node2D):
	currentTarget = target
	
# TODO: Figure out what to do about the projectile. Probably have it be fired from the tower implemenentation somehow to manage dependency injection from there
func fireProjectile():
	if currentTarget == null:
		return
	
	var projectile = ProjectileType.instance()
	projectile.position = tower.get_tip()
	projectile.direction = tower.direction
	add_child(projectile)
