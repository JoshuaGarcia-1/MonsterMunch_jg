extends CharacterBody2D


@export var speed : float = 300.0
@export var jump_velocity : float = -400.0
@export var double_jump_velocity : float = -300
@export var health : int = 3
@export var health_full = preload("res://assets/full_health.png")
@export var health_two = preload("res://assets/littlehealth_two.png")
@export var health_one = preload("res://assets/health_one.png")
@export var health_empty = preload("res://assets/health_inner.png")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
@onready var health_indicator = get_node("/root/test/user_interface/health_indicator")

func _ready():
	update_health_indicator()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
func take_damage(damage):
	health -= damage
	print("Took damage")
	update_health_indicator()
	if health <= 0:
		die()

func die():
	print("Player died")
	reset_scene()
	
func reset_scene():
	get_tree().reload_current_scene()

func update_health_indicator():
	if health == 3:
		health_indicator.texture = health_full
	elif health == 2:
		health_indicator.texture = health_two
	elif health == 1:
		health_indicator.texture = health_one
	else:
		health_indicator.texture = health_empty
