extends Area2D


func _on_EvilTree_body_entered(body):
	if body.name == "KinematicBody2D":
		body._teleport()
