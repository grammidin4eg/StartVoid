extends CharacterBody2D
class_name Bonus

const SPEED = 50
enum BONUS_TYPE { SHIELD, HEART, BOOM, SPEED }

const BONUSES = [
	BONUS_TYPE.SHIELD,
	BONUS_TYPE.HEART,
	BONUS_TYPE.BOOM,
	BONUS_TYPE.SPEED
]

const BONUS_TEXTURES = [
	preload("res://images/bonus_shield.png"),
	preload("res://images/bonus_hearth.png"),
	preload("res://images/bonus_boom.png"),
	preload("res://images/bonus_speed.png")
]

signal on_collect(type: BONUS_TYPE)

var cur_type: BONUS_TYPE = BONUS_TYPE.SHIELD
var is_collected: bool = false

func _ready():
	var rand_index:int = randi() % BONUSES.size()
	# rand_index = 3
	cur_type = BONUSES[rand_index]
	$sprite.texture = BONUS_TEXTURES[rand_index]
	$sprite.visible = true

func _physics_process(_delta):
	if Common.state == Common.EGAMESTATE.LEVEL or Common.state == Common.EGAMESTATE.READY:
		return
	velocity = Vector2.DOWN * SPEED
	move_and_slide()

func collect():
	if not is_collected:
		is_collected = true
		queue_free()
		on_collect.emit(cur_type)
