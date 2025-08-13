extends CharacterBody2D


var direction:Vector2
var gravity_direction = Vector2(0,0)
@export var gravity_force = 0.01
@export var speed: int = 200
@onready var game_manager = $".."

var last_collision_player: int = -1

func _ready() -> void:
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	last_collision_player = -1

func _physics_process(delta: float) -> void:
	direction += gravity_direction
	
	var collision_info = move_and_collide(direction * delta * speed)
	
	if collision_info:
		var player_index = collision_info.get_collider().player_index
		print(player_index)
#		Change the Color of the Ball based on the color of the paddle that it collide with
		var collide_color = collision_info.get_collider().get_node("Sprite2D").modulate
		$Sprite2D.modulate = collide_color
		if player_index == 0:
			self.set_collision_mask_value(2, true)
			self.set_collision_mask_value(1, false)
		else:
			self.set_collision_mask_value(1, true)
			self.set_collision_mask_value(2, false)
		last_collision_player = player_index
		
#		Handles ball bouncing from paddle 
		direction = direction.bounce(collision_info.get_normal())

func gavity_change(direction):
	if direction == "up":
		gravity_direction = Vector2(0, -gravity_force)
	elif direction == "down":
		gravity_direction = Vector2(0, gravity_force)
	elif direction == "right":
		gravity_direction = Vector2(gravity_force, 0)
	else:
		gravity_direction = Vector2(-gravity_force, 0)
	
func test():
	print("test")
	
#func _on_area_2d_area_entered(area: Area2D) -> void:
	##game_manager.ball_respawn()
	#print("ball die: ", area)
	
