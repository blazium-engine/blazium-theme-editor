extends Node


func _init() -> void:
	var icons: Dictionary = ProjectSettings.get_setting("gui/theme/user_icons", {})
	for icon in icons:
		ThemeDB.add_user_icon(icon, icons[icon])
