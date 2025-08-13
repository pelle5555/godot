extends Node

@export var health: int = 100

const GRAVITY = -9.82

enum Alignment {ALLY, NEUTRAL, ENEMY}

@export var unit_alignment : Alignment

#@onready var weapon: Sprite2D = $Player/Weapon

@export var my_node: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	if my_node is Node2D:
		print(my_node.get_path())
	
	match unit_alignment:
		Alignment.ALLY:
			print("hello, friend")
		Alignment.NEUTRAL:
			print("I come in peace")
		Alignment.ENEMY:
			print("DIE!")
		_:
			print("who are you?")
	
	
	if unit_alignment == Alignment.ENEMY:
		print("You are not welcome here")
	else:
		print("Welcome")	
		
		
		
	#var players = {
		#"Crook": 	{"level": 1, "health": 80}, 
		#"Villain": {"level": 30, "health": 120}, 
		#"boss": {"level": 87, "health": 500},
	#}
	#print(players["Villain"]["health"])
	#
	#
	#for username in players:
		#print(str(username))

	#for n in 8:
		#if n >= 6:
			#print(n)
		#
	#var items: Array[String] = ["Sword", "Shield", "Helmet"]
	#items.append("Potion")
	#for item in items:
		#print(item)
	

	$Label.text = "Hello World"
	$Label.modulate = Color.GREEN
	#
	#health += 10
	#
	#print(health)
	#
	#var number = 32
	#var text = "hehehe" + str(number)
	#print(text)
	#var vec2 = Vector2(0.0, 0.0)
#
	#print(add(3, 9))
	#
	#var char_height = randi_range(140, 210)
	#print("char height is: " + str(char_height) + " cm tall")
	#
	#var roll = randf()
	#if roll <= 0.7:
		#print(str(roll) + " Common")
	#else:
		#print(str(roll) + " Rare")
	#
	
func _input(event):
	if event.is_action_pressed("my_action"):
		jump()

func jump():
	print("jump")
	
func add(num1: int, num2: int) -> int:
	var result = num1 + num2
	return result 



#func _input(event):
	#if event.is_action_pressed("my_action"):
		#$Label.modulate = Color.RED
		#health -= 20
		#print(health)
		#
		#if health <= 0:
			#health = 0
			#print("You died!")
	#elif health < 50:
		#print("injured")
	#else:
		#print("you're not dead")
	#if event.is_action_released("my_action"):
		#$Label.modulate = Color.GREEN
		#


func _on_button_pressed() -> void:
	print("YOYOYOYO")
