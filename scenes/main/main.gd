extends Node2D
var enemy_count = 50

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


func _on_bonus_on_collect(type):
	if type == Bonus.BONUS_TYPE.SHIELD:
		%Player.set_immortal(4)
	if type == Bonus.BONUS_TYPE.HEART:
		%Player.heal(1)
