@tool
class_name CustomTextureRect
extends TextureRect

@export var user_icon: String:
	set(value):
		user_icon = value
		_update()


func _init() -> void:
	ThemeDB.icons_changed.connect(_update)


func _update():
	if user_icon.is_empty():
		texture = null
		return
	if ThemeDB.has_user_icon(user_icon):
		texture = ThemeDB.get_user_icon(user_icon)
	elif ThemeDB.has_icon(user_icon):
		texture = ThemeDB.get_icon(user_icon)
	else:
		texture = null


func _validate_property(property: Dictionary) -> void:
	if property["name"] == "texture":
		property["usage"] = PROPERTY_USAGE_NONE
