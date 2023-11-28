extends KinematicBody2D



const SPEED = 600

var vel = Vector2()


func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		vel.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		vel.x = SPEED
	else:
		vel.x = 0
		
	if vel:
		vel = move_and_slide(vel)
		
