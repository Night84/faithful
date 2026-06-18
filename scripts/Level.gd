extends Node2D

@export var playable_cols: int = Global.MAP_COLS
@export var playable_rows: int = Global.MAP_ROWS
@export var obstacles: Array[Vector2i] = []

func is_walkable(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.y < 0 or pos.x >= playable_cols or pos.y >= playable_rows:
		return false
	if pos in obstacles:
		return false
	return true
