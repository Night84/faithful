extends Node2D

# Typy dlaždic
enum TileType {
	FLOOR,
	WALL
}

# Layout mapy - 0 = podlaha, 1 = zeď
var map_data: Array = [
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 1, 1, 0, 0, 1, 0, 0, 1],
	[1, 0, 1, 0, 0, 0, 1, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 0, 0, 1, 0, 0, 0, 0, 1],
	[1, 0, 0, 0, 1, 0, 1, 1, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
]

func _ready() -> void:
	draw_map()

func draw_map() -> void:
	for y in range(map_data.size()):
		for x in range(map_data[y].size()):
			var tile = ColorRect.new()
			tile.size = Vector2(Global.TILE_SIZE - 2, Global.TILE_SIZE - 2)
			tile.position = Vector2(x * Global.TILE_SIZE + 1, y * Global.TILE_SIZE + 1)  + Global.MAP_OFFSET
			match map_data[y][x]:
				TileType.FLOOR: tile.color = Color(0.2, 0.2, 0.2)
				TileType.WALL:  tile.color = Color(0.5, 0.3, 0.1)
			add_child(tile)

func is_walkable(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.y < 0:
		return false
	if pos.y >= map_data.size() or pos.x >= map_data[pos.y].size():
		return false
	return map_data[pos.y][pos.x] != TileType.WALL
