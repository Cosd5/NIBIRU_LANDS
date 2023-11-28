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
var player: KinematicBody2D
var state = IDLE
func _ready():
	$AnimatedSprite.play("default")
	
func _process(delta):
	if state == IDLE:
		velocity.x = direction * Speed
		if not $RayCastR.is_colliding():
			direction *= -1
			$RayCastR.position.x *= -1
			$AnimatedSprite.flip_h = true
			
	elif state == ATTACK:
		var t = ($"../KinematicBody2D".global_position - self.global_position).normalized()
		velocity = -(Vector2.LEFT if Vector2.RIGHT.dot(t) < Vector2.LEFT.dot(t) else Vector2.RIGHT) * RunSpeed
	velocity.y += Graviry
	
	velocity = move_and_slide(velocity, Floor)
	
func check_down(veloc: Vector2):
	veloc = veloc.normalized()
	if veloc == Vector2.LEFT and !$RayCastL.is_colliding():
		velocity = Vector2.RIGHT * Speed
	elif veloc == Vector2.RIGHT and !$RayCastR.is_colliding():
		velocity = Vector2.LEFT * Speed
	
	


func _on_Area2D_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		state = ATTACK


func _on_Area2D_body_exited(body):
	if body.name == "KinematicBody2D":
		player = null
		state = IDLE
