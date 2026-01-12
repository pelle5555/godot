extends CharacterBody3D
class_name Enemy

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var enemy_speed: float = 5.0
@export var aggro_range: float = 12.0
@export var attack_range: float = 1.5
@export var max_hitpoints: int = 200
@export var enemy_damage: int = 20

var player
var provoked: bool = false
var hitpoints: int = max_hitpoints:
	set(value):
		hitpoints = value
		if hitpoints <= 0:
			queue_free()
		provoked = true

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
	#else:
		#provoked = false
	
	if provoked && distance <= attack_range:
		animation_player.play("Attack")
		
	if direction:
		look_at_target(direction)
		velocity.x = direction.x * enemy_speed
		velocity.z = direction.z * enemy_speed
	else:
		velocity.x = move_toward(velocity.x, 0, enemy_speed)
		velocity.z = move_toward(velocity.z, 0, enemy_speed)
	
	move_and_slide()
	
func look_at_target(direction: Vector3) -> void: 
	var adjusted_direction = direction
	adjusted_direction.y = 0
	look_at(global_position + adjusted_direction, Vector3.UP, true)
	
func attack() -> void:
	player.hitpoints -= enemy_damage
