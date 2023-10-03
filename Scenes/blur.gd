extends Node2D

class_name Blur

signal continue_pressed

@onready var backgroud = $backgroud

func active() -> void:
	backgroud.visible = true
	
func deactive() -> void:
	backgroud.visible = false

func get_dict() -> Dictionary:
	return {
		"is_backgroud_visible": backgroud.visible,
	}
	
func load_dict(dict: Dictionary) -> void:
	if dict.has("is_backgroud_visible"):
		backgroud.visible = dict.get("is_backgroud_visible")
	
func _on_continue_pressed() -> void:
	continue_pressed.emit()
	
