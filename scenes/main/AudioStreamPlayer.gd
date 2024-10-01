extends AudioStreamPlayer

const DEFAULT_VOLUME = 0.0
const HIDE_VOLUME = -20

const TRACKS = [
	preload("res://mus/battle1.mp3"),
	preload("res://mus/battle2.mp3"),
	preload("res://mus/battle3.mp3"),
	preload("res://mus/battle4.mp3"),
	preload("res://mus/battle5.mp3"),
]

func play_random():
	var rand_index:int = randi() % TRACKS.size()
	stream = TRACKS[rand_index]
	play()

func _on_finished():
	play_random()

func hide_music():
	volume_db = HIDE_VOLUME

func restore_music():
	volume_db = DEFAULT_VOLUME
