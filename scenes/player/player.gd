extends CharacterBody2D


const SPEED = 500.0
const HURT_IMMORTAL = 2
const CLOSE_HURT = 5
const BULLET = preload("res://scenes/shots/laser_shot.tscn")

var bullet_timer : Timer = Timer.new()
var health: int = 10
var is_visible: bool = true
var immortal: float = 0

signal change_heart(new_hearth)

func _ready():
	bullet_timer.wait_time = 0.5
	bullet_timer.one_shot = true
	add_child(bullet_timer)
	change_heart.emit(health)

func hurt(value: int):
	health -= value
	change_heart.emit(health)

func _physics_process(delta):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	if direction_x or direction_y:
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/2)
		velocity.y = move_toward(velocity.y, 0, SPEED/2)

	move_and_slide()
	
	if Input.is_action_pressed("fire") and bullet_timer.is_stopped():
		bullet_timer.start()
		create_bullet($BulletSpawnPoint_1.global_position)
		create_bullet($BulletSpawnPoint_2.global_position)
	
	# Посмотрим, какие есть коллизии
	if is_immortal():
		dec_immortal(delta)
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#var enemy : Enemy = collider as Enemy

		if collider and collider.is_in_group("EnemyBullet"):
			collider.queue_free()
			if not is_immortal():
				hurt(1)
				set_immortal(HURT_IMMORTAL)
		
		if collider and collider.is_in_group("Enemy"):
			collider.hurt(CLOSE_HURT)
			if not is_immortal():
				hurt(1)
				set_immortal(HURT_IMMORTAL)
		
func create_bullet(position):
	var bullet := BULLET.instantiate()
	bullet.global_position = position
	get_parent().add_child(bullet)
	bullet.shoot_sound()

func is_immortal() -> bool:
	return immortal > 0

func set_immortal(value: float):
	immortal = value
	$Shield.visible = true

func dec_immortal(value: float):
	immortal -= value
	if immortal <= 0:
		$Shield.visible = false
