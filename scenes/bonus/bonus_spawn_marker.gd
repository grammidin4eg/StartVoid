extends Timer

const AIM = preload("res://scenes/bonus/bonus.tscn")

signal on_bonus_collect(type)

func _ready():
	randomize()
	
func _on_timeout():
	var aim = AIM.instantiate()
	# %SpawnMarker
	%SpawnPathFollow.progress_ratio = snapped(randf_range(0, 1), 0.1)
	aim.global_position = %SpawnPathFollow/SpawnMarker.global_position
	aim.connect('on_collect', _on_collect)
	get_node('/root/Main').add_child(aim)

func _on_collect(type):
	on_bonus_collect.emit(type)
