extends KinematicBody2D


const SPEED = 200
const RUNSPEED = 400
const GRAVITY = 970
const FLOOR = Vector2(0, -1)
const FIRE = preload("res://mobs/MobFire.tscn")

enum {
	IDLE,
	ATTACK,
	MOBFIRE
}

var time = 20
var timers = 200
var scail = 0
var state = IDLE
var HP = 3
var vel = Vector2()
var der = -1
var is_alive = true
var is_fire = false
var player: KinematicBody2D
var states = IDLE

func kill():
	if HP > 0:
		HP = HP - 1
	else:
		is_alive = false
		vel.x = 0
		$Anim.play("Death")



func _physics_process(delta):
	
	if state == IDLE:
		if is_alive == true:
			if timers <= 200 && timers != 0:
				vel.x = SPEED * der
				if der == 1:
					$Anim.flip_h = false
					$Anim.play("Run")
				else:
					$Anim.flip_h = true
					$Anim.play("Run")
				timers -= 1
			elif timers == 0 && timers <= 0:
				der *= -1 
				timers += 200
				scail += 1 
			elif scail == 3:
				vel.x = 0
				scail -= 3
			if vel.x >= 0:
				$Position2D.position.x = abs($Position2D.position.x )
			elif vel.x <= 0:
				$Position2D.position.x = abs($Position2D.position.x ) * -1
			if vel.x >= 0:
				$ZoneFire/CollisionShape2D.position.x = abs($ZoneFire/CollisionShape2D.position.x )
			elif vel.x <= 0:
				$ZoneFire/CollisionShape2D.position.x = abs($ZoneFire/CollisionShape2D.position.x ) * -1
			if states == MOBFIRE && is_fire == false:
				if time != 0:
					time -= 1
				elif time == 0:
					time += 20
					is_fire == true
					var fire = FIRE.instance()
					fire.der = sign($Position2D.position.x)
					fire.position = $Position2D.global_position
					get_parent().add_child(fire)
	elif state == ATTACK:
		var t = ($"../KinematicBody2D".global_position - self.global_position).normalized()
		vel = (Vector2.LEFT if Vector2.RIGHT.dot(t) < Vector2.LEFT.dot(t) else Vector2.RIGHT) * SPEED
		
			
	
	vel.y += (GRAVITY * delta)
	move_and_slide(vel, FLOOR)
	
		
	
		
	
	



func _on_Anim_animation_finished():
	if $Anim.animation == "Death":
		queue_free()



func _on_Trigger_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		state = ATTACK


func _on_Trigger_body_exited(body):
	if body.name == "KinematicBody2D":
		player = null
		state = IDLE


func _on_AttackZone_body_entered(body):
	if body.name == "KinematicBody2D":
		$Anim.play("Attack")
		body.KillES()
	


func _on_Area2D_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		states = MOBFIRE
		



func _on_Idle_body_exited(body):
	if body.name == "KinematicBody2D":
		player = null
		states = IDLE
