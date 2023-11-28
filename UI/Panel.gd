extends Panel


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if visible == true:
			get_tree().paused = false
			visible = false
		else:
			get_tree().paused = true
			visible = true
			
func _on_Button_pressed():
	get_tree().paused = false
	visible = false
