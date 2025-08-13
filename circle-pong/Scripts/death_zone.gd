extends Area2D

@onready var game_manager = $"../.."


func _on_area_entered(area: Area2D) -> void:
	var ball = area.get_parent()
	ball.test()
	game_manager.add_score(ball.last_collision_player)
	ball.queue_free()
	game_manager.ball_respawn()
