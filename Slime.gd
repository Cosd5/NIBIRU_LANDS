extends KinematicBody2D

const SPEED = 200
const GRAVITY = 970
const JUMP = 600
const FLOOR = Vector2(0, -1)
var HP = 5

var vel = Vector2()
var der = 1
var is_alive = true


	
func kill():
	if HP != 0:
		HP = HP - 1
	else:
		is_alive = false
		vel.x = 0
		$AnimatedSprite.play("Death")



func _physics_process(delta):
	if is_alive == true:
		vel.x = SPEED * der
		if $RayCastJump.is_colliding():
			vel.y = -JUMP
			$RayCastJump.position.x *= -1
		elif not $RayCast.is_colliding():
			der *= -1
			$RayCast.position.x *= -1
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		
			
		#$Anim.play("Run")
	vel.y += (GRAVITY * delta)
	move_and_slide(vel, FLOOR)
	if is_on_wall():
		_der()
	
	
func _der():
	der *= -1
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h


func _on_Anim_animation_finished():
	if $AnimatedSprite.animation == "Death":
		queue_free()
