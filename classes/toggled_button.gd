@tool
class_name ToggledButton
extends Button


@export var pressed_icon: String:
	set(value):
		pressed_icon = value
		_update_text_and_icon()

@export var unpressed_icon: String:
	set(value):
		unpressed_icon = value
		_update_text_and_icon()

@export var pressed_text: String:
	set(value):
		pressed_text = value
		_update_text_and_icon()

@export var unpressed_text: String:
	set(value):
		unpressed_text = value
		_update_text_and_icon()


func _init() -> void:
	ThemeDB.icons_changed.connect(_update_text_and_icon)
	toggled.connect(_update_text_and_icon.unbind(1))
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _update_text_and_icon():
	var _name = "pressed" if button_pressed else "unpressed"
	text = get("%s_text" % _name)
	var icon_name: String = get("%s_icon" % _name)
	if icon_name.is_empty():
		icon = null
		return
	if ThemeDB.has_user_icon(icon_name):
		icon = ThemeDB.get_user_icon(icon_name)
	elif ThemeDB.has_icon(icon_name):
		icon = ThemeDB.get_icon(icon_name)
	else:
		icon = null


func _validate_property(property: Dictionary) -> void:
	if property["name"] == "icon":
		property["usage"] = PROPERTY_USAGE_NONE
