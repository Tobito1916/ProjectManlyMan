extends Unit


@export var detect_range : float = 100.0
@onready var game_manager = get_node("/root/Main")

func _process(delta):
	if target == null:
		var player = game_manager.player
		var dist = global_position.distance_to(player.global_position)
		
		if dist <= detect_range:
			set_target(player)
	
