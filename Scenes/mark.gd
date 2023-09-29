extends Button

class_name Mark

signal mark_pressed(mark: Mark)

@onready var animation_player = $AnimationPlayer

@export var x: int = 0
@export var y: int = 0

const _ACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 1.0)
const _DEACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 0)

const _DEFAULT_TEXT: String = "~"

var is_used = false

func _on_pressed() -> void:
	if !is_used:
		is_used = true
		print("Mark:_on_pressed")
		mark_pressed.emit(self)
	
func active(player_value: String) -> void:
	print("Mark:active:1")
	text = player_value
	print("Mark:active:2")
	animation_player.play("active")
	print("Mark:active:3")
	remove_theme_color_override("font_color")
	print("Mark:active:4")
	add_theme_color_override("font_color", _ACTIVE_WHITE_COLOR)
	print("Mark:active:5")
	
func deactive() -> void:
	is_used = false
	text = _DEFAULT_TEXT
	
	animation_player.play("deactive")
	remove_theme_color_override("font_color")
	add_theme_color_override("font_color", _DEACTIVE_WHITE_COLOR)
	
