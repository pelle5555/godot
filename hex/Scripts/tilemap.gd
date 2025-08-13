extends TileMapLayer


const grass_block = Vector2i(3,3)
const main_source = 0

func _ready() -> void:
	for y in range(3):
		for x in range(3):
			set_cell(Vector2i(2 + x, 2 + y), main_source, grass_block)
