extends Node

var score = 0
@onready var score_label: Label = $ScoreLabel

func add_points(points):
	score += points
	score_label.text = "You Ccollected " + str(score) + " coins."
