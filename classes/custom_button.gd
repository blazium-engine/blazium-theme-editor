@tool
class_name CustomButton
extends Button

var hover_scale: float = 1.05
var press_scale: float = 0.95
var anim_time: float = 0.1

@export var user_icon: String:
	set(value):
		user_icon = value
		_update_user_icon()

var animation_tween: Tween


func _ready():
	if Engine.is_editor_hint():
		return
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	ThemeDB.icons_changed.connect(_update_user_icon)


func _update_user_icon():
	if user_icon.is_empty():
		icon = null
		return
	if ThemeDB.has_user_icon(user_icon):
		icon = ThemeDB.get_user_icon(user_icon)
	elif ThemeDB.has_icon(user_icon):
		icon = ThemeDB.get_icon(user_icon)
	else:
		icon = null


func _validate_property(property: Dictionary) -> void:
	if property["name"] == "icon":
		property["usage"] = PROPERTY_USAGE_NONE
