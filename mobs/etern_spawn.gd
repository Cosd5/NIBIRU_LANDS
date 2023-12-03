extends Area2D

const ES = preload("res://mobs/ES.tscn")

enum {
	SPAWN,
	IDLE
}

var is_time = 500
var is_spawn = false
var der = -1
var states = IDLE


	
		
func _physics_process(delta):
	if is_time <= 500 && is_time != 0:
		is_time -= 1
		
	if is_spawn == true && states == SPAWN:
		is_spawn = false
		var spawn = ES.instance()
		spawn.der = sign($spawn.position.x)
		spawn.position = $spawn.global_position
		get_parent().add_child(spawn)
	elif is_spawn == false && states == IDLE && is_time == 0:
		is_time += 500
		var spawn = ES.instance()
		spawn.der = sign($spawn.position.x)
		spawn.position = $spawn.global_position
		get_parent().add_child(spawn)
			

func _on_etern_spawn_body_entered(body):
	if body.name == "KinematicBody2D":
		is_spawn = true
		states = SPAWN
		


func _on_etern_spawn_body_exited(body):
	if body.name == "KinematicBody2D":
		is_spawn = false
		states = IDLE
