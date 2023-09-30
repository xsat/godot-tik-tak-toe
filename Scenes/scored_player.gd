extends Node2D

class_name ScoredPlayer

@onready var player: Label = $player as Label
@onready var score: Label = $score as Label

@onready var animation: AnimationPlayer = $animation as AnimationPlayer

@export var player_name: String = "~"
@export var score_value: int = 0

const _ACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 1.0)
const _DEACTIVE_WHITE_COLOR: Color = Color(255, 255, 255, 0.5)

func plus_one_score() -> void:
	score_value += 1
	score.text = "%s" % score_value

func active() -> void:
	animation.play("activate")
	
	_activate_label(player)
	_activate_label(score)
	
func deactive() -> void:
	animation.play("deactivate")
	
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
	
