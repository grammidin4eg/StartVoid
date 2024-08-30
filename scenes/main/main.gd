extends Node2D


func _on_bullet_area_body_exited(body):
	body.queue_free()


func _on_middle_line_body_entered(body):
	body.cross_middle()


func _on_player_change_heart(new_hearth):
	%hpLabel.text = str(new_hearth)
