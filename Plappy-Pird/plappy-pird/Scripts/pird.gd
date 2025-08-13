extends CharacterBody2D

@onready var _BIRD: AnimatedSprite2D = $AnimatedSprite2D
@onready var _DEATH_TIMER: Timer = $DeathTimer
@onready var _DEATh_ANIMATION: AnimationPlayer = $AnimationPlayer
@export var JUMP_VELOCITY: int = 500
@export var GRAVITY: int = 500
@export var max_fall_speed: int = 500
@export var max_flap_speed: int = 300
var isFlapping: bool = false
var isDying: bool = false

func _ready() -> void:
	_BIRD.set_flip_h(true)

func _physics_process(delta: float) -> void:
	
	velocity.y += GRAVITY * delta                  
		
	if Input.is_action_just_pressed("Flap") && !isDying:
		velocity.y += -JUMP_VELOCITY
		_BIRD.play("Flap")
		
	# Clamp fall speed 
	velocity.y = min(velocity.y, max_fall_speed)
	
	# Clamp flap speed
	velocity.y = max(velocity.y, -max_flap_speed)
	
#	Clamp height
	position.y = max(position.y, -500)
	
#	rotation based on the volocity.y
	rotation = velocity.y/1000
		
	move_and_slide()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Bird area hit: ", body.get_transform())
	birdDie()

func birdDie() -> void:
	print("hit dead")
	_DEATh_ANIMATION.play("death")
	
	isDying = true
	get_node("../PipeSpawner").stopMoving()
	
	_DEATH_TIMER.start(2)
	#play death sound
	#start timer
	#show death screen
	#Show final score
	#restart button
	
func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()
	print("died")


func _on_area_2d_area_entered(area: Area2D) -> void:

	birdDie()
