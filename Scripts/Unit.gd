extends CharacterBody2D
class_name Unit

@export var health : int = 100
@export var damage : int = 20
@export var move_speed : float = 50.0

# Knockback
@export var is_knockback_enabled : bool = true
@export var knockback_force : float = 100.0
@export var knockback_duration : float = 0.5
@export var knockback_direction : Vector2 = Vector2(0, 0)

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager = get_node("/root/Main")

func _ready ():
	animated_sprite = $Sprite

func take_damage (damage_to_take, damage_origin):
	health -= damage_to_take
	
	if health <= 0:
		handle_death()
		
	animated_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	animated_sprite.modulate = Color.WHITE

	apply_knockback(damage_origin)

func apply_knockback (damage_origin):
	if is_knockback_enabled:		
		knockback_direction = (damage_origin - global_position).normalized()
		knockback_duration = 0.5

func handle_death ():
	queue_free()
