extends CharacterBody2D

const SPEED = 400
var velocity_vector = null

func _ready():
	var player = get_node('/root/Main/Player')
	if player and player.is_visible:
		var direction = velocity_vector if velocity_vector else global_position.direction_to(player.global_position)
		velocity = direction * SPEED

func _physics_process(_delta):
	move_and_slide()
