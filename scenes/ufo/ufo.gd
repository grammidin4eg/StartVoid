extends CharacterBody2D

enum UFO_DIRECT { DOWN, FOLOW }

const BULLET = preload("res://scenes/shots/ufo_ball.tscn")

const SPEED = 50
const ANGULAR_SPEED = PI
var type: UFO_DIRECT = UFO_DIRECT.DOWN

var health = 1

func _physics_process(delta):
	rotation += ANGULAR_SPEED * delta
	if type == UFO_DIRECT.DOWN:
		velocity = Vector2.DOWN * SPEED
	if type == UFO_DIRECT.FOLOW:
		var player = get_node('/root/Main/Player')
		if player and player.is_visible:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * SPEED * 5
	move_and_slide()

func cross_middle():
	type = UFO_DIRECT.FOLOW


func _on_timer_timeout():
	if type == UFO_DIRECT.DOWN:
		var bullet := BULLET.instantiate()
		bullet.global_position = position
		get_parent().add_child(bullet)

func hurt(value: int):
	health -= value
	if health < 1:
		Common.create_exposion(position, get_parent())
		queue_free()
