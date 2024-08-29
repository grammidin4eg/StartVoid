extends Node

const EXPOSION = preload("res://scenes/exposion/exposion.tscn")

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func create_exposion(position, parent):
	var exposion := EXPOSION.instantiate()
	exposion.global_position = position
	parent.add_child(exposion)
