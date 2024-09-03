extends CharacterBody2D
class_name Bonus

const SPEED = 50
enum BONUS_TYPE { SHIELD, HEART }

const BONUSES = [
	BONUS_TYPE.SHIELD,
	BONUS_TYPE.HEART
]

const BONUS_TEXTURES = [
	preload("res://images/bonus_shield.png"),
	preload("res://images/bonus_hearth.png")
]

signal on_collect(type: BONUS_TYPE)

var cur_type: BONUS_TYPE = BONUS_TYPE.SHIELD
var is_collected: bool = false

func _ready():
	var rand_index:int = randi() % BONUSES.size()
	cur_type = BONUSES[rand_index]
	$sprite.texture = BONUS_TEXTURES[rand_index]
	$sprite.visible = true

func _physics_process(_delta):
	velocity = Vector2.DOWN * SPEED
	move_and_slide()

func collect():
	if not is_collected:
		is_collected = true
		queue_free()
		on_collect.emit(cur_type)
