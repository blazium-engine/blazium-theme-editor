@tool
class_name BlaziumPanel
extends PanelContainer

var texture = load("addons/blazium_theme_editor/icons/blazium.svg")
var last_focus: Control
var fallback_focus: Control


func _draw() -> void:
	var color = ThemeDB.get_default_theme().get_color("font_color", "Colors")
	var alpha = 0.03 if color.get_luminance() > 0.5 else 0.1
	draw_texture_rect(texture, Rect2(Vector2(), get_size()), true, Color(color, alpha))


func _init() -> void:
	theme_type_variation = "FlatNormalPanel"
	ThemeDB.font_color_changed.connect(queue_redraw)


func _set_fallback_focus(control: Control) -> void:
	fallback_focus = control


func _update_last_focus() -> void:
	last_focus = get_viewport().gui_get_focus_owner()


func _restore_last_focus() -> void:
	if is_instance_valid(last_focus):
		last_focus.grab_focus()
	elif is_instance_valid(fallback_focus):
		fallback_focus.grab_focus()
