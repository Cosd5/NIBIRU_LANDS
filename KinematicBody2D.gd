extends KinematicBody2D

const GRAVITY = 970

const FLOOR = Vector2(0, -1)

const POWER_JUMP = 600

const SPEED = 800

const FIRE = preload("res://Player/Fire.tscn")

const shoot_j = false


var monye = 0
var health = 100
var vel = Vector2()
var is_dash = true
var is_fire = false
var is_fall = false
var is_alive = true
var is_run = false
var is_attack = false
var is_idle = false
func podbor():
	monye += 1

func killSlime():
	if health > 0:
		health -= 1
	else:
		$CollisionShape2D.queue_free()
		$anim.play("Death")
		is_alive = false
		
func KillES():
	if health > 0:
		health -= 5
	else:
		$CollisionShape2D.queue_free()
		$anim.play("Death")
		is_alive = false
		get_tree().reload_current_scene()


func _teleport():
	get_tree().change_scene("res://Levels/POSTLEVEL2.tscn")
	
func _teleport1():
	get_tree().change_scene("res://Levels/22level.tscn")

func _attack():
	is_attack = true
	$anim.play("Attack")
	
		
	


func _physics_process(delta):
	if is_alive == false:
		return
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if position.y >= 2500:
		get_tree().reload_current_scene()
	
	
	


		
		
		
			
		
		
	
	
	
	if Input.is_action_just_pressed("Attack"):
		_attack()
		
	
	
	
	
	
	
	
	
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = true
		$pause.visible = true
	
	if is_fire == true:
		return
	if is_run == true:
		return
	if is_attack == true:
		return
	
	
	if Input.is_action_pressed("ui_left"):
		is_run == true
	
		vel.x = -SPEED
		$anim.flip_h = true
		if vel.y == 0:
			$anim.play("Run")
			$FirePos.position.x = abs($FirePos.position.x ) * -1
			
		
			
	
	elif Input.is_action_pressed("ui_right"):
		is_run == true
		vel.x = SPEED
		$anim.flip_h = false
		if vel.y == 0:
			$anim.play("Run")
			$FirePos.position.x = abs($FirePos.position.x )
	else:
		is_idle = true
		vel.x = 0
		if is_idle == true:
			$anim.play("Idle")
		if is_attack == true:
			is_idle = false
			$anim.play("Attack")
		
			
		
		
	if Input.is_action_pressed("Fire") && is_fire == false:
		$anim.play("Shoot")
		is_fire = true
		var fire = FIRE.instance()
		fire.der = sign($FirePos.position.x)
		fire.position = $FirePos.global_position
		get_parent().add_child(fire)
	
		
	if Input.is_action_pressed("ui_accept") && is_on_floor():
		vel.y = -POWER_JUMP
		$anim.play("Jump")
		if is_fire == true:
			$anim.play("Shoot")
		if Input.is_action_pressed("ui_right"):
			$FirePos.position.x = abs($FirePos.position.x )
		elif Input.is_action_pressed("ui_left"):
			$FirePos.position.x = abs($FirePos.position.x ) * -1
		
	
	

			
	if Input.is_action_pressed("Dash"):
		is_run == false
		if Input.is_action_pressed("ui_left"):
			vel.x = -SPEED * 1.5
			$anim.flip_h = true
			
		elif Input.is_action_pressed("ui_right"):
			vel.x = SPEED * 1.5
			$anim.flip_h = false
			
		if Input.is_action_pressed("Dash"):
			is_dash = true
			$anim.play("Slide")
	
	
	
	
	
	
	if vel.y > 0:
		$anim.play("Fall")
		if is_fire == true:
			$anim.play("Shoot")
		
			
		
	
	
	if vel:
		vel.y += (GRAVITY * delta)
		vel = move_and_slide(vel, FLOOR)
		


func _on_anim_animation_finished():
	if $anim.animation == "Shoot":
		is_fire = false
	if $anim.animation == "Attack":
		is_attack = false

	

	
	
	
func _on_Area2D_body_entered(body):
	
	if body.name == "SLAME9":
		_attack()
		body.kill()
	
		
		
	
	
	
	




	
	

	
	



