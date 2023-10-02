extends Node2D

class_name Mark

signal mark_pressed(mark: Mark)

@onready var text = $action/text

const _DEFAULT_TEXT: String = "~"

func get_dict() -> Dictionary:
	return {
		"value": text.text,
		"is_visible": text.visible
	}

func load_dict(dict: Dictionary) -> void:
	if dict.has("value"):
		text.text = dict.get("value")
		
	if dict.has("is_visible"):
		text.visible = dict.get("is_visible")
	
func _on_action_pressed():
	if !text.visible:
		mark_pressed.emit(self)
		
func active(new_value: String) -> void:
	text.text = new_value
	text.visible = true
	
func deactive() -> void:
	text.text = _DEFAULT_TEXT
	text.visible = false
