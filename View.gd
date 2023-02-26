extends Camera2D

var speed = 200
var velocity = Vector2()

func _process(delta):
	position += velocity * delta * speed

func _unhandled_key_input(event):
	var keyData = [event.scancode, event.pressed]
	
	match(keyData):
		[KEY_W, true]:
			velocity.y = -1
		[KEY_W, false]:
			velocity.y = 0
		[KEY_S, true]:
			velocity.y = 1
		[KEY_S, false]:
			velocity.y = 0
		[KEY_D, true]:
			velocity.x = 1
		[KEY_D, false]:
			velocity.x = 0
		[KEY_A, true]:
			velocity.x = -1
		[KEY_A, false]:
			velocity.x = 0
