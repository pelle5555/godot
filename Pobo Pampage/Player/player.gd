extends CharacterBody3D

@export var speed: float = 4.0
@export var walk_speed: float = 4.0
@export var sprint_speed: float = 7.0
@export var jump_height: float = 1.0
@export var fall_multiplier: float = 2.0
@export var max_hitpoints: int = 100

@onready var camera_pivot: Node3D = $CameraPivot
@onready var damage_animation_player: AnimationPlayer = $DamageTexture/DamageAnimationPlayer
@onready var game_over_menu: Control = $GameOverMenu

var mouse_motion: Vector2 = Vector2.ZERO
var hitpoints: int = max_hitpoints:
	set(value):
		if value < hitpoints:
			damage_animation_player.stop(false)
			damage_animation_player.play("TakeDamage")
		hitpoints = value
		print("Ouch: ", hitpoints)
		if hitpoints <= 0:
			game_over_menu.game_over()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta: float) -> void:
	handle_camera_rotation()
	
	# Add the gravity.
	if not is_on_floor():
		if velocity.y >= 0:
			velocity += get_gravity() * delta
		else:
			velocity += get_gravity() * delta * fall_multiplier

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = sqrt(jump_height * 2.0 * (-1 * get_gravity().y))

	# Handle Sprint
	if Input.is_action_pressed("sprint"): 
		speed = sprint_speed
	else:
		speed = walk_speed
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			mouse_motion = -event.relative * 0.003
	
	if event.is_action("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	#if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: 
		#if event.is_action("shoot"):
			#Input.mouse_mode == Input.MOUSE_MODE_CAPTURED

		
func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(
		camera_pivot.rotation_degrees.x,
		-90.0,
		90.0
	)
	mouse_motion = Vector2.ZERO
