extends CharacterBody2D

enum UFO_DIRECT { DOWN, FOLOW, BOOM }

const BULLET = preload("res://scenes/shots/ufo_ball.tscn")

@export var SPEED = 50
@export var ANGULAR_SPEED = PI
@export var type: UFO_DIRECT = UFO_DIRECT.DOWN
@export var middle_type: UFO_DIRECT = UFO_DIRECT.FOLOW

@export var health = 1

signal on_destroy

func _physics_process(delta):
	if ANGULAR_SPEED > 0:
		rotation += ANGULAR_SPEED * delta
	if type == UFO_DIRECT.DOWN:
		velocity = Vector2.DOWN * SPEED
	if type == UFO_DIRECT.FOLOW:
		var player = get_node('/root/Main/Player')
		if player and player.is_visible:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * SPEED * 3
			if ANGULAR_SPEED == 0:
				look_at(player.global_position)
	move_and_slide()

func create_boom(vel_vector):
	var new_ball = BULLET.instantiate()
	new_ball.global_position = global_position
	new_ball.velocity_vector = vel_vector
	get_parent().add_child(new_ball)

func cross_middle():
	type = middle_type
	if type == UFO_DIRECT.BOOM:
		await Common.wait(2)
		for i in 36:
			create_boom(Vector2.from_angle(i * 10))
		hurt(health)

func _on_timer_timeout():
	if type == UFO_DIRECT.DOWN:
		var bullet := BULLET.instantiate()
		bullet.global_position = position
		get_parent().add_child(bullet)

func hurt(value: int):
	if health > 0:
		health -= value
		if health < 1:
			Common.create_exposion(position, get_parent())
			queue_free()
			on_destroy.emit()
