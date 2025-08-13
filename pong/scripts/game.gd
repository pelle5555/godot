extends Node

var player1_score: int = 0
var player2_score: int = 0
@onready var player1_score_label: Label = $"../UI/playerScore1"
@onready var player2_score_label: Label = $"../UI/playerScore2"

func add_points(player):
	
	print("score to: ", player)
	if player == 1:
		player1_score += 1
		player1_score_label.text = str(player1_score)
	else:
		player2_score += 1
		player2_score_label.text = str(player2_score)
