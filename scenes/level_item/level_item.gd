extends Panel
class_name LevelItemButton

enum LevelItemType { NONE }

signal level_slot_click(type: LevelItemType)

func _on_button_pressed():
	level_slot_click.emit(LevelItemType.NONE)
