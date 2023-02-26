extends Node2D

const mobType = preload("res://Mobs/Assembly/MobAssembly.tscn")
# This is being injected from here because it needs to know the path-finding, maybe figure out something better?
# I guess I need to find some balance between separation of concerns, and when to accept more global sharing
# Maybe share global state and state changes using message bus
const controlType = preload("res://Mobs/PathFinders/BasicPathFinder.tscn")
const basicTowerType = preload("res://Towers/TowerAssemblies/BasicTower.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("placeTower"):
		addTower(event.position)

func addTower(towerPosition: Vector2):
	print(towerPosition)
	var tower = basicTowerType.instance()
	tower.position = $GameGrid.snapPosition(towerPosition)
	
	add_child(tower)

func addMob(position: Vector2):
	var mob = mobType.instance()
	mob.position = position
	
	var control = controlType.instance()
	control.target = Node2D.new()
	
	mob.setController(control)
	add_child(mob)


func _on_Timer_timeout():
	var mobPosition = Vector2(
		rng.randi_range(0, 1024),
		rng.randi_range(0, 1024)
	)
	
	addMob(mobPosition)
