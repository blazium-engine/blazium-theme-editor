class_name BlaziumControl
extends Control

var last_focus: Control
var fallback_focus: Control


func _set_fallback_focus(control: Control) -> void:
	fallback_focus = control


func _update_last_focus() -> void:
	last_focus = get_viewport().gui_get_focus_owner()


func _restore_last_focus() -> void:
	if is_instance_valid(last_focus):
		last_focus.grab_focus()
	elif is_instance_valid(fallback_focus):
		fallback_focus.grab_focus()
