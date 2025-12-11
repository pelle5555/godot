extends PathFollow3D

@export var enemy_speed: float = 10
@export var enemy_damage: int = 1

@onready var base = get_tree().get_first_node_in_group("base")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * enemy_speed
	
	if progress_ratio == 1.0:
		base.take_damage(enemy_damage)
		self.queue_free()
