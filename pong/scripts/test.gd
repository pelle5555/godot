extends Sprite2D

const speed: float = 500.0
var viewport_height: float
var sprite_half_height: float
var bounds: float

func _ready() -> void:
	viewport_height = get_viewport_rect().size.y / 2
	bounds = viewport_height - texture.get_height()
	print("Viewport Height:", viewport_height)
	print("Spirte height: ", texture.get_height())
	print("bounds height: ", bounds)
	
	var image = Image.create(64, 64, false, Image.FORMAT_RGBA8) # Create a blank image (64x64)
	image.fill(Color(1, 0, 0)) # Fill with red color
	var yo = ImageTexture.create_from_image(image) # Convert to texture
	self.texture = texture # Apply to the sprite
	
func _process(delta: float) -> void:
	

	if Input.is_action_pressed("up_player_1"):
		position.y -= speed * delta
		print(position.y)
		
	elif Input.is_action_pressed("down_player_1"):
		position.y += speed * delta
		print(position.y)


	# Clamp the sprite's position to stay fully visible within the screen
	position.y = clamp(position.y, -bounds, bounds)

	#print("Sprite Position:", position.y)
	
