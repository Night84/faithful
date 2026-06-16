extends Node2D

signal heartbeats_changed(new_value: int)
signal player_died
signal player_won
signal offering_picked_up
signal altar_activated

var is_active: bool = true
var has_offering: bool = false

var traps: Array = []
var offerings: Array = []
var altars: Array = []
var pickups: Array = []

var portal: Node2D = null
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
		var picked_up = check_pickups()
		if not picked_up:
			spend_heartbeats()
		check_traps()
		check_offerings()
		check_altars()
		check_portal()

func check_traps() -> void:
	for trap in traps:
		if trap.grid_pos == grid_pos:
			spend_heartbeats(trap.damage)
			
func check_pickups() -> bool:
	for pickup in pickups:
		if pickup.grid_pos == grid_pos:
			restore_heartbeats(pickup.amount)
			pickup.queue_free()
			pickups.erase(pickup)
			return true
	return false
			
func check_offerings() -> void:
	for offering in offerings:
		if offering.grid_pos == grid_pos:
			has_offering = true
			offering.queue_free()
			offerings.erase(offering)
			emit_signal("offering_picked_up")
			
func check_altars() -> void:
	for altar in altars:
		if altar.grid_pos == grid_pos && has_offering:
			altar.is_activated = true
			has_offering = false
			emit_signal("altar_activated")

func check_portal() -> void:
	if portal != null and portal.is_active and portal.grid_pos == grid_pos:
		emit_signal("player_won")
					
func spend_heartbeats(amount: int = 1) -> void:
	heartbeats -= amount
	emit_signal("heartbeats_changed", heartbeats)
	if heartbeats <= 0:
		emit_signal("player_died")
		
func restore_heartbeats(amount: int = 1) -> void:
	heartbeats = min(heartbeats + amount, Global.MAX_HEARTBEATS)
	emit_signal("heartbeats_changed", heartbeats)
		
func grid_to_world(gpos: Vector2i) -> Vector2:
	return Vector2(gpos.x * Global.TILE_SIZE + Global.TILE_SIZE / 2,
				   gpos.y * Global.TILE_SIZE + Global.TILE_SIZE / 2)  + Global.MAP_OFFSET
