extends Unit

var agent : NavigationAgent2D

@export var detect_range : float = 100.0
@export var attack_range : float = 20.0
@export var attack_rate : float = 0.5
var last_attack_time : float

var is_spawned : bool = false

var target : CharacterBody2D

func _ready ():	
	game_manager.enemies.append(self)
	agent = $NavigationAgent2D
	animated_sprite.connect("animation_finished", on_spawn_finish)
	animated_sprite.play("spawn")

func on_spawn_finish ():
	is_spawned = true

func _physics_process(delta):
	if agent.is_navigation_finished() or !is_spawned:
		return
	
	var direction = global_position.direction_to(agent.get_next_path_position())
	velocity = direction * move_speed

	animated_sprite.flip_h = velocity.x > 0	
	animated_sprite.play("default")
	
	if is_knockback_enabled and knockback_direction != Vector2(0, 0):
		knockback_duration -= delta
		var knockback_displacement = knockback_direction * knockback_force * delta
		velocity = knockback_displacement

		if knockback_duration <= 0:
			knockback_duration = 0.5
			knockback_direction = Vector2(0, 0)
	
	move_and_slide()

	# Knockback enemies if they are in the way
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is CharacterBody2D:
			var enemy = collision.get_collider() as CharacterBody2D
			if enemy.is_in_group("enemy"):
				var knockback_origin = global_position
				enemy.apply_knockback(knockback_origin)
	
func _process(delta):
	if target == null:
		var player = game_manager.player
		if player == null:
			return
		
		var dist = global_position.distance_to(player.global_position)
				
		if dist <= detect_range:
			target = player
			
	_target_check()
	
func _target_check ():
	if target != null:
		var dist = global_position.distance_to(target.global_position)
				
		if dist <= attack_range:
			agent.target_position = global_position
			_try_attack_target()
		else:
			agent.target_position = target.global_position
			
func _try_attack_target ():
	var cur_time = Time.get_unix_time_from_system()	
	
	if cur_time - last_attack_time > attack_rate:
		target.take_damage(damage, self.global_position)
		last_attack_time = cur_time
		
func move_to_location (location):
	target = null
	agent.target_position = location

func handle_death ():
	game_manager.enemies.erase(self)
	queue_free()

# Apply knockback if hit by another enemy unit
func _on_body_entered (body):
	if body is CharacterBody2D:
		var enemy = body as CharacterBody2D
		if enemy.is_enemy:
			print("enemy_entered ")
			var direction = global_position.direction_to(enemy.global_position)
			apply_knockback(direction)
