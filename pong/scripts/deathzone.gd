extends Area2D

@onready var timer: Timer = $Timer
@onready var game_manager: Node = $"../GameManager"
@onready var audioPlayer = $"../SFX"
@export var player_side: int
const _BALL = preload("res://scenes/ball.tscn")
const _DISC = preload("res://scenes/disc.tscn")
const _DEATH_SFX = preload("res://assets/SFX/gated-drop-sound-effect-240900.mp3")
const _RESPAWN_SFX = preload("res://assets/SFX/woosh-effect-11-255592.mp3")

func _on_area_entered(area: Area2D) -> void:
	death(area)
	
func _on_body_entered(body: Node2D) -> void:
	death(body)

func _on_timer_timeout() -> void:
	#var ball = _BALL.instantiate()
	var ball = _DISC.instantiate()
	add_sibling(ball)
	audioPlayer.stream = _RESPAWN_SFX
	audioPlayer.play()

func death(item):
	item.queue_free()
	game_manager.add_points(player_side)
	timer.start()
	audioPlayer.stream = _DEATH_SFX
	audioPlayer.play()
