extends Node2D

class_name MatchLine

@export var mark_a: Mark
@export var mark_b: Mark
@export var mark_c: Mark

@onready var backgroud = $backgroud

func is_same_values() -> bool:
	return mark_a.text.text == mark_b.text.text && mark_b.text.text == mark_c.text.text
	
func is_marks_used() -> bool:
	return mark_a.text.visible && mark_b.text.visible && mark_c.text.visible
	
func get_dict() -> Dictionary:
	return {
		"is_visible": visible,
	}
	
func load_dict(dict: Dictionary) -> void:
	if dict.has("is_visible"):
		visible = dict.get("is_visible")
	
