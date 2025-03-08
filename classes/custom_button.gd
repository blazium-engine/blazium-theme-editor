@tool
class_name CustomButton
extends Button

@export var user_icon: String:
	set(value):
		user_icon = value
		_update()


func _init() -> void:
	ThemeDB.icons_changed.connect(_update)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _update():
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
