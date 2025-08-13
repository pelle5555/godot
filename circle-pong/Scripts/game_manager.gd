extends Node2D

@onready var timer = $Gravity_timer
@onready var ball = $Ball
@onready var borders = $Borders
@onready var game = $"."
@onready var label_score_player_1: Label = $UI/score_player_1
@onready var label_score_player_2: Label = $UI/score_player_2
@export var gravity_shift_time = 7
var gravity_pulse_added: bool = false
var directions = ["up", "down", "right", "left"]
var gravity_pulse = preload("res://Scenes/pulse_node.tscn").instantiate()
var _BALL = preload("res://Scenes/ball.tscn")

var player_score_1: int = 0
var player_score_2: int = 0

func _ready() -> void:
	randomize()
	timer.start(gravity_shift_time)
	
func _on_timer_timeout() -> void:
	var random_index = randi() % directions.size()
	
	if ball:
		ball.gavity_change(directions[random_index])
		magnetize(directions[random_index])
		
	timer.start(gravity_shift_time)

func magnetize(direction):
	if !gravity_pulse_added:
		game.add_child(gravity_pulse)
		gravity_pulse_added = true
	
	match direction:
		"left":
			gravity_pulse.position = Vector2(-576.0,-325.0)
			gravity_pulse.rotation = deg_to_rad(0)
		"right":
			gravity_pulse.position = Vector2(576.0,0)
			gravity_pulse.rotation = deg_to_rad(180.0)
		"up":
			gravity_pulse.position = Vector2(0, -325.0)
			gravity_pulse.rotation = deg_to_rad(90.0)
		"down":
			gravity_pulse.position = Vector2(0,325.0)
			gravity_pulse.rotation = deg_to_rad(-90.0)
			
func ball_respawn():
	game.remove_child(gravity_pulse)
	gravity_pulse_added = false
	var new_ball = _BALL.instantiate()
	add_sibling(new_ball)
	ball = new_ball

func add_score(player_index):
	if player_index == 0:
		player_score_1 += 1
		label_score_player_1.text = str(player_score_1)
	elif player_index == 1:
		player_score_2 += 1
		label_score_player_2.text = str(player_score_2)
