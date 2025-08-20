extends RigidBody3D

## How much Vertical Force to apply when moving
@export_range(500, 3000) var thrust: float = 1000.0

## How much force when rotating
@export var torgue_force: float = 100.0

var is_transitioning: bool = false
var engine_on: bool = false

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost_forward"):
		apply_central_force(basis.y * delta * thrust)
		booster_particles.emitting = true
		if !rocket_audio.playing:
			rocket_audio.play()
	else:
		booster_particles.emitting = false
		rocket_audio.stop()
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torgue_force * delta))
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torgue_force * delta))
		left_booster_particles.emitting = true
	else:
		left_booster_particles.emitting = false


func _on_body_entered(body: Node) -> void:
	if !is_transitioning:
		if "Goal" in body.get_groups():
			complete_level(body.file_path) 
			
		if "Hazard" in body.get_groups():
			crash_sequence()

func crash_sequence() -> void:
	print("Boom!")
	explosion_particles.emitting = true
	explosion_audio.play()
	stop_process()
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(next_level_file) -> void:
	print("Level Complete!")
	success_particles.emitting = true
	success_audio.play()
	stop_process()
	var tween = create_tween()
	tween.tween_interval(2)
	tween.tween_callback(
		get_tree().change_scene_to_file.bind(next_level_file)
	)
	
func stop_process() -> void:
	rocket_audio.stop()
	booster_particles.emitting = false
	right_booster_particles.emitting = false
	left_booster_particles.emitting = false
	set_process(false)
	is_transitioning = true
