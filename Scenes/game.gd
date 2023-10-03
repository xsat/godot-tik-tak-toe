extends Node

class_name Game

@onready var scored_player_x: ScoredPlayer = $ScoredPlayers/ScoredPlayer_X as ScoredPlayer
@onready var scored_player_o: ScoredPlayer = $ScoredPlayers/ScoredPlayer_O as ScoredPlayer

@onready var grid: Grid = $Grid as Grid

@onready var blur: ColorRect = $blur as ColorRect

const GAME_SAVE_PATH: String = "user://game.save"

var active_scored_player: ScoredPlayer

static var is_need_to_reset: bool = false

func _ready() -> void:
	if is_need_to_reset:
		is_need_to_reset = false
		
		_save()
	else:
		_load()
		
	_detect_active_player()
	
	grid.connnect_to_mark_pressed(_on_mark_pressed)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("open_menu"):
		_save()
		
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
func _on_mark_pressed(mark: Mark) -> void:
	mark.active(active_scored_player.player_name)
	
	var last_win_position: int = _get_player_win_positiion();
	
	if grid.is_shown_win_match_line():
		active_scored_player.plus_one_score()
	elif grid.is_all_marks_used():
		blur.visible = true
	else:
		_change_active_player()
		
func _detect_active_player() -> void:
	if scored_player_o.is_player_active:
		active_scored_player = scored_player_o
		scored_player_x.deactive()
		scored_player_o.active()
	else:
		active_scored_player = scored_player_x
		scored_player_x.active()
		scored_player_o.deactive()
		
func _change_active_player() -> void:
	if active_scored_player && active_scored_player.player_name == scored_player_x.player_name:
		scored_player_x.deactive()
		scored_player_o.active()
		active_scored_player = scored_player_o
	else:
		scored_player_x.active()
		scored_player_o.deactive()
		active_scored_player = scored_player_x
		
func _get_player_win_positiion() -> int:
	return 0
	
func _save() -> void:
	var json_string: String = JSON.stringify(get_dict())
	
	var save_game_file: FileAccess = FileAccess.open(GAME_SAVE_PATH, FileAccess.WRITE)
	save_game_file.store_line(json_string)
	save_game_file.close()
	
func _load() -> void:
	if FileAccess.file_exists(GAME_SAVE_PATH):
		var save_game_file: FileAccess = FileAccess.open(GAME_SAVE_PATH, FileAccess.READ)
		var saved_dict: Dictionary = JSON.parse_string(save_game_file.get_line()) as Dictionary
		save_game_file.close()
		
		load_dict(saved_dict)
	
func get_dict() -> Dictionary:
	return {
		"is_blur_visible": blur.visible,
		"player_scores": {
			"x": scored_player_x.get_dict(),
			"o": scored_player_o.get_dict(),
		},
		"grid": grid.get_dict(),
	}
	
func load_dict(dict: Dictionary) -> void:
	if dict.has("is_blur_visible"):
		blur.visible = dict.get("is_blur_visible") as bool
		
	if dict.has("player_scores"):
		var player_scores: Dictionary = dict.get("player_scores") as Dictionary
			
		if player_scores.has("x"):
			scored_player_x.load_dict(player_scores.get("x") as Dictionary)
			
		if player_scores.has("o"):
			scored_player_o.load_dict(player_scores.get("o") as Dictionary)
		
	if dict.has("grid"):
		grid.load_dict(dict.get("grid")  as Dictionary)
	
func _on_continue_pressed():
	_change_active_player()
	
	grid.reset()
	
	blur.visible = false
	
