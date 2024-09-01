extends CharacterBody2D
class_name Bonus

const SPEED = 50

enum BONUS_TYPE { SHIELD }

signal on_collect(type: BONUS_TYPE)
var cur_type: BONUS_TYPE = BONUS_TYPE.SHIELD

func _physics_process(delta):
	velocity = Vector2.DOWN * SPEED
	move_and_slide()


func collect():
	queue_free()
	on_collect.emit(cur_type)
