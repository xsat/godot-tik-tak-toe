extends Node2D

class_name ScoredPlayer

@onready var player: Label = $player as Label
@onready var score: Label = $score as Label

@onready var animation: AnimationPlayer = $animation as AnimationPlayer

@export var player_name: String = "~"
@export var is_player_active = true

@export var score_value: int = 0
@export var horizontal_alignment: HorizontalAlignment

const _ACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 1.0)
const _DEACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 0.5)

func get_dict() -> Dictionary:
	return {
		"player_name": player_name,
		"score_value": score_value
	}

func load_dict(dict: Dictionary) -> void:
	if dict.has("player_name"):
		player_name = dict.get("player_name")
		player.text = player_name
	
	if dict.has("is_player_active"):
		is_player_active = dict.get("is_player_active")
		if is_player_active:
			_activate_label(player)
			_activate_label(score)
		else:
			_deactivate_label(player)
			_deactivate_label(score)
			
	if dict.has("score_value"):
		score_value = dict.get("score_value")
		score.text = "%s" % score_value
	
func plus_one_score() -> void:
	score_value += 1
	score.text = "%s" % score_value

func active() -> void:
	animation.play("activate")
	
	is_player_active = true
	
	_activate_label(player)
	_activate_label(score)
	
func deactive() -> void:
	animation.play("deactivate")
	
	is_player_active = false
	
	_deactivate_label(player)
	_deactivate_label(score)
	
func _activate_label(activated_label: Label) -> void:
	activated_label.remove_theme_color_override("font_color")
	activated_label.add_theme_color_override("font_color", _ACTIVE_WHITE_COLOR)
	
func _deactivate_label(deactivated_label: Label) -> void:
	deactivated_label.remove_theme_color_override("font_color")
	deactivated_label.add_theme_color_override("font_color", _DEACTIVE_WHITE_COLOR)
	
func _ready() -> void:
	player.text = player_name
	score.text = "%s" % score_value
	player.horizontal_alignment = horizontal_alignment
	score.horizontal_alignment = horizontal_alignment
	
