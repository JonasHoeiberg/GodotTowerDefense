extends Node2D

signal projectile_fired

export (PackedScene) var TowerType
export (PackedScene) var TargetingType
export (PackedScene) var ProjectileType
export (PackedScene) var FireControlType

var tower
var targeting

var currentTarget: Node2D

func _process(delta):
	if currentTarget == null:
		return
		
	tower.aim_at(currentTarget.position)

func _ready():
	initTower()
	initTargeting()
	initFireControl()
	
func initTower():
	tower = TowerType.instance()
	add_child(tower)
	

func initTargeting():
	targeting = TargetingType.instance()
	add_child(targeting)
	targeting.connect("target_changed", self, "setTarget")
	
func initFireControl():
	var control = FireControlType.instance()
	add_child(control)
	control.connect("fired", self, "fireProjectile")
	
func setTarget(target: Node2D):
	currentTarget = target
	

func fireProjectile():
	if currentTarget == null:
		return
	
	var projectile = ProjectileType.instance()
	projectile.position = tower.get_tip()
	projectile.direction = tower.direction
	add_child(projectile)
