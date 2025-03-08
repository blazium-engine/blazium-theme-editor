@tool
class_name BlaziumThemePlugin
extends EditorPlugin

static var singleton: BlaziumThemePlugin

var theme_editor: ThemeEditor
var reload_theme: Button


func _enter_tree() -> void:
	if Engine.is_editor_hint():
		theme_editor = preload("res://addons/blazium_theme_editor/editor/tools/theme_editor.tscn").instantiate()
		theme_editor.hide()
		EditorInterface.get_base_control().add_child(theme_editor)
		add_tool_menu_item("Blazium Theme Editor", _show_theme_editor)
		reload_theme = Button.new()
		reload_theme.tooltip_text = "Reload Project Theme"
		reload_theme.icon = preload("editor/icons/ReloadTheme.svg")
		reload_theme.pressed.connect(_reload_theme)
		add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, reload_theme)
	singleton = self


func _exit_tree() -> void:
	if Engine.is_editor_hint():
		EditorInterface.get_base_control().remove_child(theme_editor)
		theme_editor.free()
		theme_editor = null
		remove_tool_menu_item("Blazium Theme Editor")
		remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, reload_theme)
		reload_theme.free()
	singleton = null


func _reload_theme():
	var project_theme: String = ProjectSettings.get_setting("gui/theme/custom", "")
	if project_theme.is_empty():
		return
	if not ResourceLoader.exists(project_theme, "Theme"):
		return
	ResourceLoader.load(project_theme).generate_theme_styles()


func _show_theme_editor():
	if Engine.is_editor_hint():
		if theme_editor.visible:
			theme_editor.grab_focus()
		else:
			theme_editor.show()
