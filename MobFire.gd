extends Area2D


const SPEED = 2000

var vel = Vector2()

export var der = 1


func _physics_process(delta):
	vel.x = SPEED * delta * der
	$AnimatedSprite.flip_h = true
	if der == -1:
		$AnimatedSprite.flip_h = false
	
	translate(vel)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "TileMap":
		queue_free()
	elif body.name == "KinematicBody2D":
		body.KillES()
		queue_free()
