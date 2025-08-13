extends CharacterBody2D

var startDir:int
var direction:Vector2

func _ready() -> void:
	if randf() < 0.5:
		startDir = 1
	else:
		startDir = -1
		
	direction = Vector2(startDir, randf_range(-0.6, 0.6)).normalized()

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(direction * delta * 300)
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())
