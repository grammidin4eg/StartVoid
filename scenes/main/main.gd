extends Node2D
var enemy_count = 50

const LASER_BALL = preload("res://scenes/shots/laser_ball_shot.tscn")

func _ready():
	_update_aim_counter()

func _on_bullet_area_body_exited(body):
	body.queue_free()


func _on_middle_line_body_entered(body):
	body.cross_middle()


func _on_player_change_heart(new_hearth):
	%hpLabel.text = str(new_hearth)


func _on_spawn_timer_on_aim_destroy():
	enemy_count -= 1
	_update_aim_counter()

func _update_aim_counter():
	%AimCountLabel.text = str(enemy_count)

func add_laset_ball(vel_vector):
	var new_ball = LASER_BALL.instantiate()
	new_ball.global_position = %Player.global_position
	new_ball.velocity_vector = vel_vector
	new_ball.power = 5
	add_child(new_ball)

func _on_bonus_on_collect(type):
	match type:
		Bonus.BONUS_TYPE.SHIELD:
			%Player.set_immortal(4)
		Bonus.BONUS_TYPE.HEART:
			%Player.heal(1)
		Bonus.BONUS_TYPE.BOOM:
			for i in 36:
				add_laset_ball(Vector2.from_angle(i * 10))
		Bonus.BONUS_TYPE.SPEED:
			%Player.set_double_speed()
