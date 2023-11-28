extends KinematicBody2D

const SPEED = 200
const RUNSPEED = 400
const GRAVITY = 970
const FLOOR = Vector2(0, -1)
const FIRE = preload("res://mobs/MobFire.tscn")

enum {
	IDLE,
	RUN,
	MOBFIRE
}

var time = 20
var fire = 3
var state = IDLE
var HP = 3
var vel = Vector2()
var der = 1
var is_alive = true
var is_run = false
var is_fire = false
var player: KinematicBody2D
var states = IDLE
var states1 = IDLE

func kill():
	if HP > 0:
		HP = HP - 1
	else:
		is_alive = false
		vel.x = 0
		$AnimatedSprite.play("Death")



func _physics_process(delta):
	
	if state == IDLE:
		if is_alive == true:
			vel.x = SPEED * der
			$AnimatedSprite.play("Run")
			if vel.x >= 0:
				$Fire.position.x = abs($Fire.position.x )
			elif vel.x <= 0:
				$Fire.position.x = abs($Fire.position.x ) * -1
			if states == MOBFIRE && is_fire == false:
				if time != 0:
					time -= 1
				elif time == 0:
					time += 10
					fire -= 1
					if fire == 0:
						state = RUN
					is_run == true
					is_fire == true
					var fire = FIRE.instance()
					fire.der = sign($Fire.position.x)
					fire.position = $Fire.global_position
					get_parent().add_child(fire)
						
	elif state == RUN:
		var t = ($"../KinematicBody2D".global_position - self.global_position).normalized()
		vel = (Vector2.LEFT if Vector2.RIGHT.dot(t) < Vector2.LEFT.dot(t) else Vector2.RIGHT) * -RUNSPEED
			
	
	vel.y += (GRAVITY * delta)
	move_and_slide(vel, FLOOR)
	if is_on_wall():
		_der()
	
		
	
	
func _der():
	der *= -1
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h




func _on_RunZone_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		states1 = RUN


func _on_RunZone_body_exited(body):
	if body.name == "KinematicBody2D":
		player = null
		is_run == false
		fire += 3
		states1 = IDLE
		state = IDLE
		

func _on_ZoneFire_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		states = MOBFIRE
		



func _on_Idle_body_exited(body):
	if body.name == "KinematicBody2D":
		player = null
		states = IDLE


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Death":
		queue_free()
