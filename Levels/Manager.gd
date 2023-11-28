extends Node
onready var pause_menu = "res://UI/PauseMenu.tscn"

var game_paused: bool = false

func _process(delta):
	if Input.is_action_just_pressed("Pause1"):
		game_paused = !game_paused
		
		
	if game_paused == true:
		get_tree().paused = true
		
	else:
		get_tree().paused = false
	
	
