extends Area2D

var direction: Vector2 
var startDir: int
var diff: int
var previous_position: Vector2
@onready var audioPlayer = $"../SFX"
@onready var startTimer: Timer = $Timer
@onready var camera: Camera2D = $"../Camera2D"
@export var speed: int = 0
@export var maxSpeed: int = 1000

@export var current_trail: Trail

const _BOUNCE_SOUND = preload("res://assets/SFX/retro-game-sfx_jump-bumpwav-14853.mp3")

func _ready() -> void:
	if randf() < 0.5:
		startDir = 1
	else:
		startDir = -1
	direction = Vector2(startDir, randf_range(-0.6, 0.6)).normalized()
	startTimer.start()
	
	make_trail()
	
func _on_timer_timeout() -> void:
	speed = 300

func _process(delta: float) -> void:
	previous_position = position
	position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	direction *= Vector2(1,-1)
	camera.add_trauma(0.4)
	play_hit_SFX()
	
func _on_body_entered(body: Node2D) -> void:
	diff = clamp(int($".".get_position().y) - int(body.get_position().y), -1, 1)
	direction *= Vector2(-1, 1)
	#direction *= Vector2(diff, 1)
	body.shake()
	play_hit_SFX()
	speed_incease()
	print("diff: ", diff)
	
func play_hit_SFX():
	audioPlayer.stream = _BOUNCE_SOUND
	audioPlayer.play()

func speed_incease():
	if speed < maxSpeed:
		speed *= 1.1
		
func make_trail() -> void:
	if current_trail:
		current_trail.stop()
	current_trail = Trail.create()
	add_child(current_trail)
