extends CharacterBody2D

@export var SPEED = 800
@export var power = 1
@export var velocity_vector = Vector2.UP
@export var is_play_sound: bool = true

var is_disable: bool = false

func _physics_process(_delta):
	if Common.state == Common.EGAMESTATE.LEVEL or Common.state == Common.EGAMESTATE.READY:
		return
	velocity = velocity_vector * SPEED
	move_and_slide()
	
	# Посмотрим, какие есть коллизии
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#var enemy : Enemy = collider as Enemy

		if collider and collider.is_in_group("EnemyBullet"):
			collider.queue_free()
			queue_free()
		
		if collider and collider.is_in_group("Enemy") and not is_disable:
			is_disable = true
			queue_free()
			collider.hurt(power)

func shoot_sound():
	if is_play_sound:
		$ShootSound.play()
