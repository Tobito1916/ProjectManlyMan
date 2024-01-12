class_name Hitbox
extends Area2D

@export var damage : int = 20

func _init():
	collision_layer = 2
	collision_mask = 0
