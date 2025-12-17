extends Area3D

@export var speed: float = 30.0

var direction := Vector3.FORWARD

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_projectile_remover_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_area"):
		print(area)
		area.get_parent().take_damage(25)
		queue_free()
