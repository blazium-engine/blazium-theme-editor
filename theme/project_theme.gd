@tool
class_name GeneratedTheme
extends Theme

const BASE_COLOR := "base_color"
const ACCENT_COLOR := "accent_color"
const ACCENT_COLOR_2 := "accent_color2"
const BG_COLOR := "bg_color"
const BG_COLOR_2 := "bg_color2"
const FONT_COLOR := "font_color"
const MONO_COLOR := "mono_color"
const FONT_OUTLINE_COLOR := "font_outline_color"
const NORMAL_COLOR := "normal_color"
const HOVER_COLOR := "hover_color"
const PRESSED_COLOR := "pressed_color"
const DISABLED_COLOR := "disabled_color"

const CONST_MARGIN := "margin"
const CONST_PADDING := "padding"
const CONST_BORDER_WIDTH := "border_width"
const CONST_CORNER_RADIUS := "corner_radius"
const CONST_BORDER_PADDING := "border_padding"
const CONST_FOCUS_CORNERS := "focus_corners"
const CONST_FONT_OUTLINE_SIZE := "font_outline_size"

# Theme Styles
var flat_normal_panel := StyleBoxFlat.new()
var flat_alter_panel := StyleBoxFlat.new()
var selected_panel := StyleBoxFlat.new()
var content_panel := StyleBoxFlat.new()
var custom_popup_panel := StyleBoxFlat.new()
var scroll_panel := StyleBoxFlat.new()
var selected_button_normal := StyleBoxFlat.new()
var selected_button_hover := StyleBoxFlat.new()
var selected_button_pressed := StyleBoxFlat.new()
var selected_button_disabled := StyleBoxFlat.new()
var line_edit_no_bg := StyleBoxEmpty.new()
var button_normal := StyleBoxFlat.new()
var button_hover := StyleBoxFlat.new()
var button_pressed := StyleBoxFlat.new()
var button_hover_pressed := StyleBoxFlat.new()
var button_disabled := StyleBoxFlat.new()
var label_style := StyleBoxFlat.new()

func generate_theme_styles():
	var def := ThemeDB.get_default_theme()
	# FlatNormalPanel
	def.set_type_variation("FlatNormalPanel", "PanelContainer")
	def.set_stylebox("panel", "FlatNormalPanel", flat_normal_panel)
	flat_normal_panel.set_content_margin_all(0)
	# FlatAlterPanel
	def.set_type_variation("FlatAlterPanel", "PanelContainer")
	def.set_stylebox("panel", "FlatAlterPanel", flat_alter_panel)
	# ContentPanel
	def.set_type_variation("ContentPanel", "PanelContainer")
	def.set_stylebox("panel", "ContentPanel", content_panel)
	# CustomPopupPanel
	def.set_type_variation("CustomPopupPanel", "PanelContainer")
	def.set_stylebox("panel", "CustomPopupPanel", custom_popup_panel)
	# SelectedPanel
	def.set_type_variation("SelectedPanel", "PanelContainer")
	def.set_stylebox("panel", "SelectedPanel", selected_panel)
	# CustomPopupVBox
	def.set_type_variation("CustomPopupVBox", "VBoxContainer")
	# LineEditNoBg
	def.set_type_variation("LineEditNoBG", "LineEdit")
	def.set_stylebox("normal", "LineEditNoBG", line_edit_no_bg)
	def.set_stylebox("readonly", "LineEditNoBG", line_edit_no_bg)
	# HeaderLarge
	def.set_type_variation("HeaderLarge", "Label")
	def.set_constant("shadow_offset_x", "HeaderLarge", 0)
	def.set_constant("shadow_offset_y", "HeaderLarge", 4)
	# HeaderLargeFit
	def.set_type_variation("HeaderLargeFit", "Label")
	def.set_constant("shadow_offset_x", "HeaderLargeFit", 0)
	def.set_constant("shadow_offset_y", "HeaderLargeFit", 4)
	# ScrollPanel
	def.set_type_variation("ScrollPanel", "ScrollContainer")
	def.set_stylebox("panel", "ScrollPanel", scroll_panel)
	# ChatRichTextLabel
	def.set_type_variation("ChatRichTextLabel", "RichTextLabel")
	var italics_font: FontFile = preload("fonts/Inter/Inter_Italics.ttf")
	def.set_font("italics_font", "ChatRichTextLabel", italics_font)
	# SelectedButton
	def.set_type_variation("SelectedButton", "Button")
	def.set_stylebox("normal", "SelectedButton", selected_button_normal)
	def.set_stylebox("pressed", "SelectedButton", selected_button_pressed)
	def.set_stylebox("hover", "SelectedButton", selected_button_hover)
	def.set_stylebox("disabled", "SelectedButton", selected_button_disabled)
	# Button
	def.set_stylebox("normal", "Button", button_normal);
	def.set_stylebox("hover", "Button", button_hover);
	def.set_stylebox("pressed", "Button", button_pressed);
	def.set_stylebox("disabled", "Button", button_disabled);
	# CheckButton and CheckBox
	def.set_stylebox("hover_pressed", "CheckButton", button_hover_pressed);
	def.set_stylebox("hover_pressed", "CheckBox", button_hover_pressed);
	# LineEdit
	def.set_stylebox("normal", "LineEdit", button_normal)
	def.set_stylebox("readonly", "LineEdit", button_disabled)
	# EmojiButton
	def.set_type_variation("EmojiButton", "FlatButton")
	def.set_color("icon_normal_color", "EmojiButton", Color.WHITE)
	def.set_color("icon_hover_color", "EmojiButton", Color.WHITE)
	def.set_color("icon_focus_color", "EmojiButton", Color.WHITE)
	def.set_color("icon_pressed_color", "EmojiButton", Color.WHITE)
	def.set_color("icon_disabled_color", "EmojiButton", Color(1, 1, 1, 0.4))
	# BGLabel
	def.set_type_variation("BGLabel", "Label")
	def.set_stylebox("normal", "BGLabel", label_style)

	colors_changed()
	icons_changed()
	scale_changed()
	margin_changed()
	padding_changed()
	border_width_changed()
	corner_radius_changed()
	border_padding_changed()
	font_size_changed()
	font_color_changed()
	font_outline_size_changed()
	font_outline_color_changed()


func colors_changed():
	var def := ThemeDB.get_default_theme()
	var base_color = _get_color(BASE_COLOR)
	var accent_color = _get_color(ACCENT_COLOR)
	var bg_color = _get_color(BG_COLOR)
	var normal_color = _get_color(NORMAL_COLOR)
	var hover_color = _get_color(HOVER_COLOR)
	var pressed_color = _get_color(PRESSED_COLOR)
	var disabled_color = _get_color(DISABLED_COLOR)
	#var accent_color2 = _get_color(ACCENT_COLOR_2)
	#var bg_color2 = _get_color(BG_COLOR_2)
	#var font_color = _get_color(FONT_COLOR)
	#var font_outline_color = _get_color(FONT_OUTLINE_COLOR)
	#var mono_color = _get_color(MONO_COLOR)

	flat_normal_panel.bg_color = base_color
	flat_alter_panel.bg_color = bg_color
	content_panel.bg_color = Color(bg_color, 0.8)
	scroll_panel.bg_color = Color(base_color, 0.8)
	custom_popup_panel.bg_color = bg_color
	custom_popup_panel.border_color = base_color
	custom_popup_panel.shadow_color = Color(0, 0, 0, 0.5)
	def.set_color("font_shadow_color", "HeaderLarge", disabled_color)
	def.set_color("font_shadow_color", "HeaderLargeFit", disabled_color)
	var comp_color = accent_color
	comp_color.h = wrapf(0.0, 1.0, comp_color.h + 0.2)
	selected_button_normal.bg_color = Color(comp_color, 0.6)
	selected_button_hover.bg_color = Color(comp_color, 0.8)
	selected_button_disabled.bg_color = Color(comp_color, 0.4)
	selected_button_pressed.bg_color = comp_color
	selected_panel.bg_color = comp_color

	button_normal.bg_color = Color(normal_color, 0.6)
	button_hover.bg_color = Color(hover_color, 0.8)
	button_pressed.bg_color = pressed_color
	button_hover_pressed.bg_color = pressed_color
	button_disabled.bg_color = Color(disabled_color, 0.4)
	
	label_style.bg_color = Color(normal_color, 0.6)


func icons_changed():
	#var base_scale := _get_theme_scale()
	#var font_color := _get_color(FONT_COLOR)
	#var accent_color := _get_color(ACCENT_COLOR)
	pass


func font_color_changed():
	#var font_color := _get_color(FONT_COLOR)
	pass


func scale_changed():
	var def := ThemeDB.get_default_theme()
	var base_scale := _get_theme_scale()

	content_panel.content_margin_left = 16 * base_scale
	content_panel.content_margin_right = 16 * base_scale
	content_panel.content_margin_bottom = 32 * base_scale
	custom_popup_panel.border_width_bottom = floor(80 * base_scale)
	custom_popup_panel.corner_radius_top_left = floor(16 * base_scale)
	custom_popup_panel.corner_radius_top_right = floor(16 * base_scale)
	custom_popup_panel.set_content_margin_all(16 * base_scale)
	custom_popup_panel.shadow_size = 4 * base_scale
	def.set_constant("separation", "CustomPopupVBox", floor(32 * base_scale))
	scroll_panel.set_corner_radius_all(floor(4 * base_scale))


func margin_changed():
	var def := ThemeDB.get_default_theme()
	var margin := _get_const(CONST_MARGIN)

	def.set_constant("h_scroll_bar_separation", "ScrollContainer", int(margin))
	def.set_constant("v_scroll_bar_separation", "ScrollContainer", int(margin))


func padding_changed():
	var padding := _get_const(CONST_PADDING)

	flat_alter_panel.set_content_margin_all(padding)
	selected_panel.set_content_margin_all(padding)


func font_size_changed():
	var def := ThemeDB.get_default_theme()
	var font_size := def.get_default_font_size()

	def.set_font_size("font_size", "HeaderLarge", font_size + 48)
	def.set_font_size("font_size", "HeaderLargeFit", font_size + 24)


func border_width_changed():
	#var border_width := _get_const(CONST_BORDER_WIDTH)
	pass


func corner_radius_changed():
	var corner_radius := _get_const(CONST_CORNER_RADIUS)
	#var focus_corners := _get_const(CONST_FOCUS_CORNERS)

	selected_panel.set_corner_radius_all(int(corner_radius))
	selected_button_normal.set_corner_radius_all(int(corner_radius))
	selected_button_hover.set_corner_radius_all(int(corner_radius))
	selected_button_pressed.set_corner_radius_all(int(corner_radius))
	selected_button_disabled.set_corner_radius_all(int(corner_radius))
	button_normal.set_corner_radius_all(int(corner_radius))
	button_hover.set_corner_radius_all(int(corner_radius))
	button_pressed.set_corner_radius_all(int(corner_radius))
	button_hover_pressed.set_corner_radius_all(int(corner_radius))
	button_disabled.set_corner_radius_all(int(corner_radius))
	label_style.set_corner_radius_all(int(corner_radius))


func border_padding_changed():
	var border_padding := _get_const(CONST_BORDER_PADDING)

	line_edit_no_bg.set_content_margin_all(border_padding)
	selected_button_normal.set_content_margin_all(border_padding)
	selected_button_hover.set_content_margin_all(border_padding)
	selected_button_pressed.set_content_margin_all(border_padding)
	selected_button_disabled.set_content_margin_all(border_padding)
	button_normal.set_content_margin_all(border_padding)
	button_hover.set_content_margin_all(border_padding)
	button_pressed.set_content_margin_all(border_padding)
	button_hover_pressed.set_content_margin_all(border_padding)
	button_disabled.set_content_margin_all(border_padding)


func font_outline_size_changed():
	#var font_outline_size := _get_const(CONST_FONT_OUTLINE_SIZE)
	pass


func font_outline_color_changed():
	#var font_color_color := _get_color(FONT_OUTLINE_COLOR)
	pass


func _get_color(property: String) -> Color:
	return ThemeDB.get_default_theme().get_color(property, "Colors")


func _get_const(property: String) -> float:
	return ThemeDB.get_default_theme().get_constant(property, "Constants")


func _get_theme_scale() -> float:
	return ThemeDB.get_default_theme().get_default_base_scale()


func _init() -> void:
	ThemeDB.colors_changed.connect(colors_changed)
	ThemeDB.icons_changed.connect(icons_changed)
	ThemeDB.scale_changed.connect(scale_changed)
	ThemeDB.margin_changed.connect(margin_changed)
	ThemeDB.padding_changed.connect(padding_changed)
	ThemeDB.font_size_changed.connect(font_size_changed)
	ThemeDB.font_color_changed.connect(font_color_changed)
	ThemeDB.border_width_changed.connect(border_width_changed)
	ThemeDB.corner_radius_changed.connect(corner_radius_changed)
	ThemeDB.border_padding_changed.connect(border_padding_changed)
	ThemeDB.font_outline_size_changed.connect(font_outline_size_changed)
	ThemeDB.font_outline_color_changed.connect(font_outline_color_changed)
	generate_theme_styles.call_deferred()
