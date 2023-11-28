extends KinematicBody2D

var velocity = Vector2()
enum {
	IDLE,
	ATTACK
}
var direction = 1
const Graviry = 200
const Speed = 70
const RunSpeed = 300
const Floor = Vector2(0, -1)

var der = 1
var HP = 5
var is_alive = true
var is_fire = false
var player: KinematicBody2D
var state = IDLE

	
func _process(delta):
	if state == IDLE:
		velocity.x = direction * Speed
		if not $RayCastR.is_colliding():
			direction *= -1
			$RayCastR.position.x *= -1
			$AnimatedSprite.flip_h = true
			
	elif state == ATTACK:
		var t = ($"../KinematicBody2D".global_position - self.global_position).normalized()
		velocity = (Vector2.LEFT if Vector2.RIGHT.dot(t) < Vector2.LEFT.dot(t) else Vector2.RIGHT) * RunSpeed
	velocity.y += Graviry
	
	velocity = move_and_slide(velocity, Floor)
	
		
func _on_Area2D_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		state = ATTACK


func _on_Area2D_body_exited(body):
	if body.name == "KinematicBody2D":
		player = null
		state = IDLE
	
	
func kill():
	if HP != 0:
		HP = HP - 1
	else:
		is_alive = false
		velocity.x = 0
		$AnimatedSprite.play("Death")
	
		


func _direction():
	direction *= -1
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

		
func _on_Anim_animation_finished():
	if $AnimatedSprite.animation == "Death":
		queue_free()
