extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

@export var enemy_speed = 5.0
@export var aggro_range: float = 12.0

var player
var provoked: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if provoked:
		navigation_agent_3d.target_position = player.global_position

func _physics_process(delta: float) -> void:
	var next_position = navigation_agent_3d.get_next_path_position()
		
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction = global_position.direction_to(next_position)
	var distance = global_position.distance_to(player.global_position)
	
	if distance <= aggro_range:
		provoked = true
	else:
		provoked = false
		
	if direction:
		velocity.x = direction.x * enemy_speed
		velocity.z = direction.z * enemy_speed
	else:
		velocity.x = move_toward(velocity.x, 0, enemy_speed)
		velocity.z = move_toward(velocity.z, 0, enemy_speed)
		
	
	move_and_slide()
