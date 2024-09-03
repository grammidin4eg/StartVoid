extends AudioStreamPlayer

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

func _ready():
	play_random()


func _on_finished():
	play_random()
