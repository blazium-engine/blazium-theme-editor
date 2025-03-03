@tool
class_name BlaziumThemePlugin
extends EditorPlugin

var theme_editor: ThemeEditor
static var singleton: BlaziumThemePlugin


func _enter_tree() -> void:
	if Engine.is_editor_hint():
		theme_editor = preload("res://addons/blazium_theme_editor/editor/tools/theme_editor.tscn").instantiate()
		theme_editor.hide()
		EditorInterface.get_base_control().add_child(theme_editor)
		add_tool_menu_item("Blazium Theme Editor", _show_theme_editor)
	singleton = self


func _exit_tree() -> void:
	if Engine.is_editor_hint():
		EditorInterface.get_base_control().remove_child(theme_editor)
		theme_editor.free()
		theme_editor = null
		remove_tool_menu_item("Blazium Theme Editor")
	singleton = null



func _show_theme_editor():
	if Engine.is_editor_hint():
		if theme_editor.visible:
			theme_editor.grab_focus()
		else:
			theme_editor.show()
