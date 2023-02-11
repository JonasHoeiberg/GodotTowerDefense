extends Node2D

export (PackedScene) var Projectile

func _unhandled_input(event):
	if (event is InputEventMouseMotion):
		$Tower.aim_at(event.position)
		
	if (event is InputEventMouseButton && event.pressed):
		var projectile = Projectile.instance()
		projectile.position = $Tower.position
		projectile.direction = $Tower.direction
		add_child(projectile)
