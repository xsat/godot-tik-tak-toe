extends Node2D

class_name Mark

signal mark_pressed(mark: Mark)

@onready var text = $action/text

@export var x: int = 0
@export var y: int = 0

const _DEFAULT_TEXT: String = "~"

func _on_action_pressed():
	if !text.visible:
		mark_pressed.emit(self)
		
func active(player_value: String) -> void:
	text.text = player_value
	text.visible = true
	
func deactive() -> void:
	text.text = _DEFAULT_TEXT
	text.visible = false
