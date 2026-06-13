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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and state != GameState.PLAYING:
		get_tree().reload_current_scene()
		
func _ready() -> void:
	player.grid_map = grid_map
	player.heartbeats_changed.connect(_on_heartbeats_changed)
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
