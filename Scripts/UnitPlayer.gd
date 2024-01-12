extends Unit

@onready var katana : Node2D = $Katana
var katana_scale_x : float = 0
var player_scale_x : float = 0

func _ready ():	
	game_manager.player = self
	katana_scale_x = katana.scale.x
	player_scale_x = self.scale.x

func _physics_process (delta):
	get_input()
	move_and_slide()
	
func get_input ():
	# Movement
	var inputDirection = Input.get_vector("left", "right", "up", "down")
	velocity = inputDirection * move_speed
	
	if !inputDirection:
		animated_sprite.play("idle")
		katana.play_animation("idle")
	else:
		animated_sprite.flip_h = inputDirection.x < 0 or inputDirection.x == 0 and animated_sprite.flip_h
		katana.set_flip_h(animated_sprite.flip_h)
		animated_sprite.play("walk")

	# Attack
	var inputAttack = Input.is_action_just_pressed("attack")
	if inputAttack:
		attack()

func attack ():	
	katana.attack()
