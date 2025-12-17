extends PathFollow3D

@export var enemy_speed: float = 10
@export var enemy_damage: int = 1
@export var max_health: int = 50

var current_health: int:
	set(health_in):
		current_health = health_in
		if current_health < 1:
			queue_free()
	
@onready var base = get_tree().get_first_node_in_group("base")

func _ready() -> void:
	current_health = max_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * enemy_speed
	
	if progress_ratio == 1.0:
		base.take_damage(enemy_damage)
		queue_free()

func take_damage(damage) -> void:
	current_health -= damage
