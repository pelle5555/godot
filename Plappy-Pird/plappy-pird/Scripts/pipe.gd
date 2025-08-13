extends CharacterBody2D


@onready var pointText = $"../TestText"

func _on_area_2d_area_exited(area: Area2D) -> void:
	get_node("../../pointText").addPoint()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
