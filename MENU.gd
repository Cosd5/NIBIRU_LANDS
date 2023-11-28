extends Node2D




func _on_Play_pressed():
	get_tree().change_scene("res://Levels/POSTMENU.tscn")




func _on_Quit_pressed():
	get_tree().quit()


func _on_CL_pressed():
	get_tree().change_scene("res://MENUCHOOSE.tscn")
