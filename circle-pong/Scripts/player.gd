extends CharacterBody2D

var viewport_middle: Vector2 = Vector2(0, 0)
var radius = 280
var angle:float
var angular_speed: float = PI
var offset: Vector2
var control_up: String
var control_down: String
var current_direction: String
@export var player_index = 0
@onready var sprite = $Sprite2D

func _ready() -> void:
	if player_index == 0:
		angle = PI
		control_up = "up_1"
		control_down = "down_1"
		sprite.modulate = Color(0.208, 0.482, 0.651)
	else:
		angle = 0
		control_up = "down_2"
		control_down = "up_2"
		sprite.modulate = Color(0.651, 0.208, 0.290)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		print("block the player")
		
	if Input.is_action_pressed(control_up):
		current_direction = "up"
		angle += angular_speed * delta
		
	if Input.is_action_pressed(control_down):
		current_direction = "down"
		angle -= angular_speed * delta
	
	offset = Vector2(cos(angle), sin(angle)) * radius
	global_position = viewport_middle + offset
	rotation = angle - PI
