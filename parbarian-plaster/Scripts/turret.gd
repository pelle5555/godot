extends Node3D

@export var projectile: PackedScene
@export var turrent_range: float = 10.0

var enemy_path: Path3D
var target: PathFollow3D

@onready var turret_head: Node3D = $TurretBase/TurretHead
@onready var cannon: Node3D = $TurretBase/TurretHead/Cannon
@onready var turret_base: Node3D = $TurretBase
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target:
		animation_player.play("fire")
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = cannon.global_position
		shot.direction = turret_base.global_transform.basis.z

func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < turrent_range && enemy.progress > best_progress:
				best_target = enemy
				best_progress = enemy.progress

	return best_target
