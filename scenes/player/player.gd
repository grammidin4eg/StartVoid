extends CharacterBody2D


const SPEED = 500.0
const BULLET = preload("res://scenes/shots/laser_shot.tscn")

var bullet_timer : Timer = Timer.new()
var health: int = 10
var is_visible: bool = true

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
		
func create_bullet(position):
	var bullet := BULLET.instantiate()
	bullet.global_position = position
	get_parent().add_child(bullet)
	bullet.shoot_sound()
