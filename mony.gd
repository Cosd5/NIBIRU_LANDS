extends KinematicBody2D

var player: KinematicBody2D

enum {
	IDLE,
	DEATH
}

var state = IDLE

func _physics_process(delta):
	if state == IDLE:
		$AnimatedSprite.play("default")
	elif state == DEATH:
		$AnimatedSprite.play("New Anim")

func _on_Area2D_body_entered(body):
	if body.name == "KinematicBody2D":
		player = null
		state = DEATH
		body.podbor()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "New Anim":
		queue_free()
