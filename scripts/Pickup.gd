extends Node2D

var grid_pos: Vector2i = Vector2i(0, 0)
var amount: int = 3

func _ready() -> void:
	position = grid_to_world(grid_pos)

func grid_to_world(gpos: Vector2i) -> Vector2:
	return Vector2(gpos.x * Global.TILE_SIZE + Global.TILE_SIZE / 2,
				   gpos.y * Global.TILE_SIZE + Global.TILE_SIZE / 2) + Global.MAP_OFFSET
