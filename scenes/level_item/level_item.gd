extends Button
class_name LevelItemButton

enum LevelItemType { HOMING_MISSILE }

signal level_slot_click(type: LevelItemType)

const type_strings = ['A homing missile']
const types = [LevelItemType.HOMING_MISSILE]
const pics = [preload("res://images/homing_missile_level.png")]

@export var type: LevelItemType

func _ready():
	type = types[0]
	text = type_strings[0]
	icon = pics[0]

func on_click():
	level_slot_click.emit(type)


