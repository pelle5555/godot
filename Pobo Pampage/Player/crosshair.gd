@tool
extends Control

var crosshair_color: Color = Color.DARK_RED
func _draw() -> void:
	draw_line(Vector2(8,0), Vector2(18,0), crosshair_color, 2.5)
	draw_line(Vector2(-8,0), Vector2(-18,0), crosshair_color, 2.5)
	draw_line(Vector2(0,8), Vector2(0,18), crosshair_color, 2.5)
	draw_line(Vector2(0,-8), Vector2(0,-18), crosshair_color, 2.5)
	draw_circle(Vector2.ZERO, 2, crosshair_color)
