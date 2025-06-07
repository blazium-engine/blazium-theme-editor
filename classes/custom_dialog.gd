@tool
class_name CustomDialog
extends PanelContainer

signal confirmed
signal cancelled

@export var text := "Confirm":
	set(value):
		text = value
		label.text = text

@export var confirm := "Yes":
	set(value):
		confirm = value
		confirm_button.text = confirm
		confirm_button.visible = not confirm.is_empty()

@export var cancel := "No":
	set(value):
		cancel = value
		cancel_button.text = cancel
		cancel_button.visible = not cancel.is_empty()

var main_vb := VBoxContainer.new()
var label := Label.new()
var cancel_button := CustomButton.new()
var confirm_button := CustomButton.new()


func _init(dialog_text := "Confirm", confirm_text := "Yes", cancel_text := "No") -> void:
	text = dialog_text
	confirm = confirm_text
	cancel = cancel_text
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	mouse_default_cursor_shape = Control.CURSOR_FORBIDDEN
	mouse_force_pass_scroll_events = false
	z_as_relative = false
	z_index = 4096
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0.2)
	add_theme_stylebox_override("panel", style)
	var center_container = CenterContainer.new()
	add_child(center_container)
	var panel := PanelContainer.new()
	panel.theme_type_variation = "CustomPopupPanel"
	center_container.add_child(panel)
	main_vb.theme_type_variation = "CustomPopupVBox"
	panel.add_child(main_vb)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.custom_minimum_size.x = 460
	label.theme_type_variation = "HeaderMedium"
	main_vb.add_child(label)
	var buttons_hb := BoxContainer.new()
	buttons_hb.set_script(load("res://addons/blazium_shared_menus/game_shared_ui/orientation_box_container.gd"))
	buttons_hb.alignment = BoxContainer.ALIGNMENT_CENTER
	buttons_hb.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	buttons_hb.add_theme_constant_override("separation", 24)
	main_vb.add_child(buttons_hb)
	cancel_button.user_icon = "cancel"
	cancel_button.expand_text = false
	cancel_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	cancel_button.expand_icon = true
	cancel_button.pressed.connect(_on_button_pressed.bind(false))
	cancel_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	buttons_hb.add_child(cancel_button)
	confirm_button.user_icon = "check_circle"
	confirm_button.expand_text = false
	confirm_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	confirm_button.expand_icon = true
	confirm_button.pressed.connect(_on_button_pressed.bind(true))
	confirm_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	buttons_hb.add_child(confirm_button)


func _on_button_pressed(is_confirmed: bool):
	if is_confirmed:
		confirmed.emit()
	else:
		cancelled.emit()
	hide()
