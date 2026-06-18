extends Node2D

@export var playable_cols: int = Global.MAP_COLS
@export var playable_rows: int = Global.MAP_ROWS

func is_walkable(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.y < 0 or pos.x >= playable_cols or pos.y >= playable_rows:
		return false
	return true
