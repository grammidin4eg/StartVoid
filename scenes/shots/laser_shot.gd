extends CharacterBody2D

const SPEED = 800

func _physics_process(delta):
	velocity = Vector2.UP * SPEED
	move_and_slide()

func shoot_sound():
	$ShootSound.play()
