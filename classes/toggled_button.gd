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

var _tween: Tween

func _init() -> void:
	set_pivot_offset(size * 0.5)
	ThemeDB.icons_changed.connect(_update_text_and_icon)
	toggled.connect(_update_text_and_icon.unbind(1))
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	pressed.connect(_pressed_timeout)

	# Connect interaction signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	focus_entered.connect(_on_mouse_entered)
	focus_exited.connect(_on_mouse_exited)

func _ready():
	_tween = create_tween()
	set_pivot_offset(size * 0.5)

func _size_changed():
	set_pivot_offset(size * 0.5)

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

func _on_mouse_entered():
	if _tween:
		_tween.kill()
	scale = Vector2.ONE
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_mouse_exited():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _pressed_timeout():
	disabled = true

	# Add a squish animation on click
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2(1.0, 0.9), 0.05).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(0.5).timeout
	disabled = false

func _validate_property(property: Dictionary) -> void:
	if property["name"] == "icon":
		property["usage"] = PROPERTY_USAGE_NONE
