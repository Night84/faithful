extends Node2D

signal heartbeats_changed(new_value: int)
signal player_died
signal player_won

var is_active: bool = true
var traps: Array = []

var grid_map: Node2D = null
var grid_pos: Vector2i = Vector2i(5, 5)
var heartbeats: int = Global.MAX_HEARTBEATS

func _ready() -> void:
	position = grid_to_world(grid_pos)

func _unhandled_input(event: InputEvent) -> void:
	if not is_active:
		return
		
	if event.is_action_pressed("ui_right"):
		try_move(Vector2i(1, 0))
	elif event.is_action_pressed("ui_left"):
		try_move(Vector2i(-1, 0))
	elif event.is_action_pressed("ui_down"):
		try_move(Vector2i(0, 1))
	elif event.is_action_pressed("ui_up"):
		try_move(Vector2i(0, -1))

func try_move(dir: Vector2i) -> void:
	var new_pos = grid_pos + dir
	if grid_map == null or grid_map.is_walkable(new_pos):
		grid_pos = new_pos
		position = grid_to_world(grid_pos)
		spend_heartbeats()
		check_traps()
		if grid_map != null and grid_map.is_exit(grid_pos):
			emit_signal("player_won")

func check_traps() -> void:
	for trap in traps:
		if trap.grid_pos == grid_pos:
			spend_heartbeats(trap.damage)
			
func spend_heartbeats(amount: int = 1) -> void:
	heartbeats -= amount
	emit_signal("heartbeats_changed", heartbeats)
	if heartbeats <= 0:
		emit_signal("player_died")

func grid_to_world(gpos: Vector2i) -> Vector2:
	return Vector2(gpos.x * Global.TILE_SIZE + Global.TILE_SIZE / 2,
				   gpos.y * Global.TILE_SIZE + Global.TILE_SIZE / 2)  + Global.MAP_OFFSET
