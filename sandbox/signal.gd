extends Node

signal leveled_up

var xp := 0

func _on_timer_timeout() -> void:
	xp += 5
	print(xp)
	if xp >= 20:
		xp = 0
		leveled_up.emit()

func _on_leveled_up() -> void:
	print("DING!")
