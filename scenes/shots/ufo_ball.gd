extends CharacterBody2D

const SPEED = 400

func _ready():
	var player = get_node('/root/Main/Player')
	if player and player.is_visible:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED

func _physics_process(delta):
	move_and_slide()
