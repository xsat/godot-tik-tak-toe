extends Label

class_name LocalPlayer

@onready var animation_player = $AnimationPlayer

const ACTIVE_WHITE_COLOR = Color(255, 255, 255, 1.0)
const DEACTIVE_WHITE_COLOR = Color(255, 255, 255, 0.5)

func active():
	animation_player.play("active")
	
	remove_theme_color_override("font_color")
	add_theme_color_override("font_color", ACTIVE_WHITE_COLOR)
	
func deactive():
	animation_player.play("deactive")
	
	remove_theme_color_override("font_color")
	add_theme_color_override("font_color", DEACTIVE_WHITE_COLOR)
	
