extends Area2D



const SPEED = 2500

var vel = Vector2()

export var der = 1


func _physics_process(delta):
	vel.x = SPEED * delta * der
	
	if der == -1:
		$Sprite.flip_h = true
	
	translate(vel)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Node2D_body_entered(body):
	if body.name == "TileMap":
		queue_free()
	elif body.name == "ES":
		body.kill()
		queue_free()
	elif body.name == "SLAME":
		body.kill()
	elif body.name == "ADEPT_EVIL":
		body.kill()
		queue_free()
	elif body.name == "ES2":
		body.kill()
		queue_free()
	elif body.name == "Slime":
		body.kill()
	elif body.name == "SLAME2":
		body.kill()
	elif body.name == "SLAME3":
		body.kill()
	elif body.name == "SLAME4":
		body.kill()
	elif body.name == "SLAME5":
		body.kill()
	elif body.name == "SLAME6":
		body.kill()
	elif body.name == "SLAME7":
		body.kill()
	elif body.name == "SLAME8":
		body.kill()
	elif body.name == "SLAME9":
		body.kill()
	elif body.name == "SLAME10":
		body.kill()
	elif body.name == "SLAME11":
		body.kill()
	elif body.name == "SLAME12":
		body.kill()
	elif body.name == "SLAME13":
		body.kill()
	elif body.name == "SLAME14":
		body.kill()
	elif body.name == "ES3":
		body.kill()
		queue_free()
	elif body.name == "ES4":
		body.kill()
		queue_free()
	elif body.name == "KinematicBody2D41":
		body.kill()
		queue_free()
	elif body.name == "ES5":
		body.kill()
		queue_free()
	elif body.name == "SLOME":
		body.kill()
	elif body.name == "ES6":
		body.kill()
		queue_free()
	elif body.name == "ES7":
		body.kill()
		queue_free()
	elif body.name == "ES8":
		body.kill()
		queue_free()
	elif body.name == "ES9":
		body.kill()
		queue_free()
