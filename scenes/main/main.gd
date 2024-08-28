extends Node2D


func _on_bullet_area_body_exited(body):
	body.queue_free()
