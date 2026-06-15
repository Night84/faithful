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
@onready var portal: Node2D = $Portal
@onready var traps_container: Node2D = $Traps
@onready var offerings_container: Node2D = $Offerings
@onready var altars_container: Node2D = $Altars

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
	
	var altar = preload("res://scenes/Altar.tscn").instantiate()
	altar.grid_pos = Vector2i(4, 8)
	altars_container.add_child(altar)
	
	portal.set_grid_pos(Vector2i(8, 8))
	player.portal = portal
	
	player.traps = traps_container.get_children()
	player.offerings = offerings_container.get_children()
	player.altars = altars_container.get_children()
	player.grid_map = grid_map
	player.heartbeats_changed.connect(_on_heartbeats_changed)
	player.offering_picked_up.connect(_on_offering_picked_up)
	player.altar_activated.connect(_on_altar_activated)
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
	hud.show_offering()
	
func _on_altar_activated() -> void:
	portal.set_active(true)
