@tool
class_name BlaziumPanel
extends PanelContainer

var texture = preload("../icons/blazium.svg")


func _draw() -> void:
	var color = ThemeDB.get_default_theme().get_color("font_color", "Colors")
	var alpha = 0.03 if color.get_luminance() > 0.5 else 0.1
	draw_texture_rect(texture, Rect2(Vector2(), get_size()), true, Color(color, alpha))


func _init() -> void:
	theme_type_variation = "FlatNormalPanel"
	ThemeDB.font_color_changed.connect(queue_redraw)
