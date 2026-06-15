extends Node2D

var is_active: bool = false
var grid_pos: Vector2i = Vector2i(0, 0)

func _ready() -> void:
	position = grid_to_world(grid_pos)
	update_visual()
	
func set_grid_pos(pos: Vector2i) -> void:
	grid_pos = pos
	position = grid_to_world(grid_pos)
	
func set_active(value: bool) -> void:
	is_active = value
	update_visual()
	
func update_visual() -> void:
	if is_active:
		modulate.a = 1.0
	else:
		modulate.a = 0.2
	
func grid_to_world(gpos: Vector2i) -> Vector2:
	return Vector2(gpos.x * Global.TILE_SIZE + Global.TILE_SIZE / 2,
				   gpos.y * Global.TILE_SIZE + Global.TILE_SIZE / 2) + Global.MAP_OFFSET
