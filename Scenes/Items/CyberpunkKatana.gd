extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animated_sprite : AnimatedSprite2D = $Sprite
@onready var initial_scale_x : float = self.scale.x

@export var damage : int = 20

func attack():
	animation_player.play("attack")
	
func play_animation(animation : String):
	animation_player.queue(animation)

func set_flip_h(flip_h : bool):
	if flip_h:
		self.scale.x = -initial_scale_x
	else:
		self.scale.x = initial_scale_x
