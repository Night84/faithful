extends Node2D

enum GameState {
	PLAYING,
	GAME_OVER,
	WON
}

var state: GameState = GameState.PLAYING

@onready var grid_map: Node2D = $GridMap
@onready var player: Node2D = $Player
@onready var label: Label = $Label
@onready var hud: Node2D = $HUD
@onready var traps_container: Node2D = $Traps
@onready var offerings_container: Node2D = $Offerings

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and state != GameState.PLAYING:
		get_tree().reload_current_scene()
		
func _ready() -> void:
	var trap = preload("res://scenes/Trap.tscn").instantiate()
	trap.grid_pos = Vector2i(3, 4)
	trap.damage = 3
	traps_container.add_child(trap)
	
	var trap2 = preload("res://scenes/Trap.tscn").instantiate()
	trap2.grid_pos = Vector2i(3, 6)
	trap2.damage = 1
	traps_container.add_child(trap2)
	
	var offering = preload("res://scenes/Offering.tscn").instantiate()
	offering.grid_pos = Vector2i(3, 8)
	offerings_container.add_child(offering)
	
	player.traps = traps_container.get_children()
	player.offerings = offerings_container.get_children()
	player.grid_map = grid_map
	player.heartbeats_changed.connect(_on_heartbeats_changed)
	player.offering_picked_up.connect(_on_offering_picked_up)
	player.player_died.connect(_on_player_died)
	player.player_won.connect(_on_player_won)
		
func _on_heartbeats_changed(new_value: int) -> void:
	hud.update_hearts(new_value)

func _on_player_died() -> void:
	state = GameState.GAME_OVER
	player.is_active = false
	hud.visible = false
	label.text = "GAME OVER"
	label.visible = true

func _on_player_won() -> void:
	state = GameState.WON
	player.is_active = false
	hud.visible = false
	label.text = "WIN"
	label.visible = true

func _on_offering_picked_up() -> void:
	label.text = "OFFERING"
	label.visible = true
