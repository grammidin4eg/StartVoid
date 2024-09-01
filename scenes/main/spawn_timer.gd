extends Timer

const AIM = [preload("res://scenes/ufo/ufo.tscn"), preload("res://scenes/ufo/big_ufo.tscn")]

signal on_aim_destroy

func _ready():
	randomize()
	
func _on_timeout():
	var rand_index:int = randi() % AIM.size()
	var aim = AIM[rand_index].instantiate()
	# %SpawnMarker
	%SpawnPathFollow.progress_ratio = snapped(randf_range(0, 1), 0.1)
	aim.global_position = %SpawnPathFollow/SpawnMarker.global_position
	aim.connect('on_destroy', _on_aim_destroy)
	get_node('/root/Main').add_child(aim)

func _on_aim_destroy():
	on_aim_destroy.emit()
