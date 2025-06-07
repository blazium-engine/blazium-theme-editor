@tool
class_name ToggledButton
extends Button

@export var press_timeout: float = 0.25

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
var hover_scale: float = 1.1
var press_scale: float = 0.95
var anim_time: float = 0.1

func _init() -> void:
	ThemeDB.icons_changed.connect(_update_text_and_icon)
	toggled.connect(_update_text_and_icon.unbind(1))
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	pressed.connect(_pressed_timeout)
	resized.connect(_resized)

	# Connect interaction signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	focus_entered.connect(_on_mouse_entered)
	focus_exited.connect(_on_mouse_exited)

func _ready():
	_resized()

func _resized():
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
	_animate_scale(hover_scale)

func _on_mouse_exited():
	_animate_scale(1.0)

func _play_press_animation():
	_animate_scale(press_scale)
	await get_tree().create_timer(anim_time).timeout
	_animate_scale(hover_scale if get_rect().has_point(get_local_mouse_position()) else 1.0)

func _pressed_timeout():
	disabled = true

	# Add a squish animation on click
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2(1.0, 0.9), 0.05).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(press_timeout).timeout
	disabled = false

func _validate_property(property: Dictionary) -> void:
	if property["name"] == "icon":
		property["usage"] = PROPERTY_USAGE_NONE

func _animate_scale(target_scale: float):
	if _tween:
		_tween.kill()
	scale = Vector2.ONE
	_tween = create_tween()
	
	if target_scale != 1.0:
		_tween.tween_property(self, "scale", Vector2(target_scale + 0.1, target_scale + 0.1), anim_time/2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "scale", Vector2(target_scale, target_scale), anim_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
