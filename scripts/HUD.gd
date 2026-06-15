extends Node2D

var heart_rects: Array = []
var offering_rect: ColorRect = null

func _ready() -> void:
	create_hearts()
	create_offering_indicator()

func create_hearts() -> void:
	var total_width = Global.MAX_HEARTBEATS * 30 + (Global.MAX_HEARTBEATS - 1) * 6
	var start_x = (640 - total_width) / 2
	var start_y = (Global.UI_HEIGHT - 25) / 2
	
	for i in range(Global.MAX_HEARTBEATS):
		var heart = ColorRect.new()
		heart.size = Vector2(30, 30)
		heart.position = Vector2(start_x + i * 36, start_y)
		heart.color = Color(0.9, 0.1, 0.1)
		add_child(heart)
		heart_rects.append(heart)

func update_hearts(current: int) -> void:
	for i in range(heart_rects.size()):
		if i < current:
			heart_rects[i].color = Color(0.9, 0.1, 0.1)  # červená
		else:
			heart_rects[i].color = Color(0.513, 0.513, 0.513, 1.0)  # šedá = prázdné

func create_offering_indicator() -> void:
	offering_rect = ColorRect.new()
	offering_rect.size = Vector2(20, 20)
	offering_rect.position = Vector2(Global.MAP_WIDTH - 30, (Global.UI_HEIGHT - 20) / 2)
	offering_rect.color = Color(0.3, 0.3, 0.3)  # šedá = nemáš
	add_child(offering_rect)

func show_offering() -> void:
	offering_rect.color = Color(1.0, 0.85, 0.0)
