extends Label

class_name LocalPlayer

@onready var animation_player = $AnimationPlayer

const _ACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 1.0)
const _DEACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 0.5)

func active() -> void:
	animation_player.play("active")
	
	remove_theme_color_override("font_color")
	add_theme_color_override("font_color", _ACTIVE_WHITE_COLOR)
	
func deactive() -> void:
	animation_player.play("deactive")
	
	remove_theme_color_override("font_color")
	add_theme_color_override("font_color", _DEACTIVE_WHITE_COLOR)
	
