@tool
class_name Avatar
extends Control

@export var texture_scale: float = 1.0:
	set(value):
		value = maxf(0.5, value)
		if texture_scale != value:
			texture_scale = value
			_update()

@export var texture: Texture2D:
	set(value):
		texture = value
		_update()
		if texture:
			texture.changed.connect(_update)
			var _size := texture.get_size()
			frame = maxi(frame, (h_frames * v_frames) - 1)

@export var h_frames := 1:
	set(value):
		value = clampi(value, 1, 32)
		h_frames = value
		if texture:
			_update()

@export var v_frames := 1:
	set(value):
		value = clampi(value, 1, 32)
		v_frames = value
		if texture:
			_update()

@export var frame: int:
	set(value):
		if not texture:
			return
		var _size := texture.get_size()
		value = wrapi(value, 0, (h_frames * v_frames) - 1)
		frame = value
		queue_redraw()


func _get_minimum_size() -> Vector2:
	if not texture:
		return Vector2.ZERO
	return (texture.get_size() / Vector2(h_frames, v_frames)) * texture_scale


func _draw() -> void:
	if texture:
		var _size := texture.get_size() / Vector2(h_frames, v_frames)
		@warning_ignore("integer_division")
		var src := Rect2(_size * Vector2(frame % h_frames, floor(frame / v_frames)), _size)
		draw_texture_rect_region(texture, Rect2(Vector2.ZERO, _size * texture_scale), src)


func _update() -> void:
	update_minimum_size()
	queue_redraw()
