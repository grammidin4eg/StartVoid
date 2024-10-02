extends CharacterBody2D

@export var SPEED = 500
@export var power = 3
@export var velocity_vector = Vector2.UP
@export var is_play_sound: bool = true
var enemy = null
var has_enemy = false

var is_disable: bool = false

func _physics_process(_delta):
	if Common.state == Common.EGAMESTATE.LEVEL or Common.state == Common.EGAMESTATE.READY or is_disable:
		return
	
	if has_enemy and enemy != null:
		var direction = global_position.direction_to(enemy.global_position)
		velocity = direction * SPEED
		look_at(enemy.global_position)
		rotate(deg_to_rad(90))
	else:
		velocity = velocity_vector * SPEED
		rotation = 0
		has_enemy = false
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
			enemy = null
			queue_free()
			collider.hurt(power)

func shoot_sound():
	if is_play_sound:
		$ShootSound.play()

func _on_enemy_body_entered(body):
	if !has_enemy:
		enemy = body
		has_enemy = true
