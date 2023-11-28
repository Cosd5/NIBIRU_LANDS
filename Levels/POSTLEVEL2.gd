extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Input.is_action_just_pressed("SKIP"):
		get_tree().change_scene("res://Levels/MENU.tscn")




func _on_Button_pressed():
	get_tree().change_scene("res://Levels/3level.tscn")
