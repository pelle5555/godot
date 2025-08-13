extends CharacterBody2D

const speed: float = 500.0
var viewportHeight: float
var shapeHeight: float
var bounds: float
var controlUp: String
var controlDown: String
@export var player_index: int = 0
@onready var shakeAnimation = $AnimationPlayer


func _ready() -> void:
	viewportHeight = get_viewport_rect().size.y / 2
	shapeHeight = get_node("CollisionShape2D").shape.height
	bounds = viewportHeight - (shapeHeight / 2)
	
	if player_index == 0:
		controlUp = "up_player_1"
		controlDown = "down_player_1"
	else:
		controlUp = "up_player_2"
		controlDown = "down_player_2"
		
func _process(delta: float) -> void:
	
	if Input.is_action_pressed(controlUp):
		position.y -= speed * delta
		
	elif Input.is_action_pressed(controlDown):
		position.y += speed * delta
	
	# Clamp the sprite's position to stay fully visible within the screen
	position.y = clamp(position.y, -bounds, bounds)
	
func shake() -> void: 
	shakeAnimation.play("Shake")
