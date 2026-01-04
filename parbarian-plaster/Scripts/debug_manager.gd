extends Node


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("increase"):
		increase_game_speed()
	if Input.is_action_just_pressed("decrease"):
		decrease_game_speed()
	
	
func increase_game_speed() -> void:
	if Engine.time_scale <= 6:
		Engine.time_scale += 1

func decrease_game_speed() -> void:
	if Engine.time_scale > 0:
		Engine.time_scale -= 1
