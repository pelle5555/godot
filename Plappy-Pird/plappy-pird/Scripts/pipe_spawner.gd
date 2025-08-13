extends Node2D

@onready var timer: Timer = $Timer
var pipeScene = preload("res://Scenes/Pipe.tscn")

@export var spawnTime: float = 4
@export var minSpawnTime: float = 2
@export var pipeSpeed: int = 200
@export var maxPipeSpeed: int = 400
@export var pipePosMax: int = 450
@export var pipePosMin: int = 50
var pipePosY: int

func _ready() -> void:
	timer.start(spawnTime)

func _process(delta: float) -> void: 
	for pipe in get_children():
		if pipe is CharacterBody2D:
			pipe.position.x += delta * -pipeSpeed
			
func stopMoving():
	pipeSpeed = 0

func _on_timer_timeout() -> void:
	var pipe = pipeScene.instantiate()
	add_child(pipe)
	
#	Handle random spawn height
	pipePosY = randf_range(pipePosMax, pipePosMin)

	pipe.position.y = -pipePosY
	
#	Handle Movement speed increase
	if(pipeSpeed < maxPipeSpeed):
		pipeSpeed += 10
		print("pipe Speed: ", pipeSpeed)
		
	
#	Handle spawn time
	spawnTime -= 0.1
	spawnTime = max(spawnTime, minSpawnTime)
	print("Spawn Time: ", spawnTime)
	timer.start(spawnTime)
