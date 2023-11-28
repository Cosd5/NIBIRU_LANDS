extends KinematicBody2D
var vel = Vector2()
func _physics_process(delta):
	if vel.x == 0:
		$Ani.play("d")
