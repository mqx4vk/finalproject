extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_velocity : float = -250.0
@export var double_jump_velocity : float = -200

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var Smile : TextureRect = $AnimatedSprite2D/Smile
@onready var active = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var player1 = true
var smile = false

func _physics_process(delta):
	if smile:
		Smile.show()
	else:
		Smile.hide()
	if player1:
		$robot.hide()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
		if was_in_air == true:
			land()
			
		was_in_air = false

#Handle Shooting if Robot
	if Input.is_action_just_pressed("shoot"):
		if not player1:
			shoot()
		else:
			if smile:
				smile = false
			else:
				smile = true
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if player1:
			if is_on_floor():
				# Normal jump from floor
				jump()
			elif not has_double_jumped:
				# Double jump in air
				double_jump()
		else: 
			jump()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && animated_sprite.animation != "jump_end":
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("jump_loop")
		elif not player1 and Input.is_action_pressed("shoot"):
			#ADD X WALKING HERE
			animated_sprite.play("shoot")
		else:
			if direction.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump():
	if player1:
		velocity.y = jump_velocity
		animated_sprite.play("jump_start")
		animation_locked = true
	else: 
		velocity.y = jump_velocity
		animated_sprite.play("fly")
		animation_locked = true
	
func double_jump():
	velocity.y = double_jump_velocity
	animated_sprite.play("jump_double")
	animation_locked = true
	has_double_jumped = true

func land():
	animated_sprite.play("jump_end")
	animation_locked = false

func _on_animated_sprite_2d_animation_finished():
	if(["jump_end", "jump_start", "jump_double"].has(animated_sprite.animation)):
		animation_locked = false
		
func _on_robot_animation_finished():
	if(["jump_end", "jump_start", "jump_double"].has(animated_sprite.animation)):
		animation_locked = false

func shoot():
		animated_sprite.play("shoot")
		animation_locked = false
