extends Node2D

var selected_unit : CharacterBody2D
var player : CharacterBody2D
var enemies : Array[CharacterBody2D]

@export var max_enemies : int = 6
@export var spawn_radius : int = 200
@export var spawn_chance : int = 1

var enemy_scene = preload("res://scenes/characters/Enemy.tscn")

func _process (delta):
	# Spawn enemies in a radius around the player
	if enemies.size() < max_enemies:
		var spawn = randi() % 100
		if spawn < spawn_chance:
			var enemy = enemy_scene.instantiate()
			# Random position on a fixed circle around the player
			var spawn_pos = player.global_position + Vector2.RIGHT.rotated(randf() * 2 * PI) * spawn_radius
			# prevent spawning outside the map
			spawn_pos.x = clamp(spawn_pos.x, 0, get_viewport_rect().size.x)
			spawn_pos.y = clamp(spawn_pos.y, 0, get_viewport_rect().size.y)

			# Set the enemy position to the spawn position
			enemy.set_position(spawn_pos)
			add_child(enemy)
			enemies.append(enemy)
