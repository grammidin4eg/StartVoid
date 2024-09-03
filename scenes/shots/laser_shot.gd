extends CharacterBody2D

@export var SPEED = 800
@export var power = 1

var is_disable: bool = false

func _physics_process(_delta):
	velocity = Vector2.UP * SPEED
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
	$ShootSound.play()
