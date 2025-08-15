extends RigidBody3D

var rotation_force: float = 100.0
var movement_force: float = 1000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost_forward"):
		apply_central_force(basis.y * delta * movement_force)
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, rotation_force * delta))
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -rotation_force * delta))


func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups():
		print("You win!")
		
	if "Hazard" in body.get_groups():
		print("You've Crashed!")
