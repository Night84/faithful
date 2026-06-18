extends Node2D

enum GameState {
	PLAYING,
	GAME_OVER,
	WON
}

var state: GameState = GameState.PLAYING

@onready var level: Node2D = $CurrentLevel/Level01
@onready var player: Node2D = $Player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and state != GameState.PLAYING:
		get_tree().reload_current_scene()
		
func _ready() -> void:
	player.level = level
