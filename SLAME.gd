extends KinematicBody2D

const SPEED = 200
const RUNSPEED = 400
const GRAVITY = 970
const JUMP = 600
const FLOOR = Vector2(0, -1)

enum {
	IDLE,
	ATTACK
}

var player: KinematicBody2D
var vel = Vector2()
var der = 1
var state = IDLE
var is_attacking = false
var is_alive = true
var HP = 1

func kill():
	
	is_alive = false
	vel.x = 0
	$Anim.play("Death")

func _physics_process(delta):
	if is_alive == true && is_attacking == false && state == IDLE:
		vel.x = SPEED * der
		$Anim.play("Run")
		if $RayCast2D.is_colliding():
			vel.y = -JUMP
			$RayCast2D.position.x *= -1
		elif not $RayCast2D2.is_colliding():
			der *= -1
			$RayCast2D2.position.x *= -1
			$Anim.flip_h = !$Anim.flip_h
	elif state == ATTACK:
		var t = ($"../../KinematicBody2D".global_position - self.global_position).normalized()
		vel = (Vector2.LEFT if Vector2.RIGHT.dot(t) < Vector2.LEFT.dot(t) else Vector2.RIGHT) * RUNSPEED
	
	vel.y += (GRAVITY * delta)
	move_and_slide(vel, FLOOR)
	if is_on_wall():
		_der()
	
func _der():
	der *= -1
	scale.x *= -1
	$Area2D/CollisionShape2D.position.x *= -1
	
	
func _on_Anim_animation_finished():
	if $Anim.animation == "Death":
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "KinematicBody2D":
		$Anim.play("Attack")
		body.killSlime()


func _on_Area2D2_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		state = ATTACK


func _on_Area2D2_body_exited(body):
	if body.name == "KinematicBody2D":
		player = null
		state = IDLE
