extends Node2D

class_name MatchLine

@onready var backgroud = $backgroud

func get_dict() -> Dictionary:
	return {
		"is_visible": visible
	}

func load_dict(dict: Dictionary) -> void:
	if dict.has("is_visible"):
		visible = dict.get("is_visible")
	
