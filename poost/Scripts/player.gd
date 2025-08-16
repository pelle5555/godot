extends RigidBody3D

## How much Vertical Force to apply when moving
@export_range(500, 3000) var thrust: float = 1000.0

## How much force when rotating
@export var torgue_force: float = 100.0

var is_transitioning: bool = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost_forward"):
		apply_central_force(basis.y * delta * thrust)
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torgue_force * delta))
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torgue_force * delta))


func _on_body_entered(body: Node) -> void:
	if !is_transitioning:
		if "Goal" in body.get_groups():
			complete_level(body.file_path) 
			
		if "Hazard" in body.get_groups():
			crash_sequence()

func crash_sequence() -> void:
	print("Boom!")
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(next_level_file) -> void:
	print("Level Complete!")
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_callback(
		get_tree().change_scene_to_file.bind(next_level_file)
	)
	
