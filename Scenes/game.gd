extends Node

class_name Game

@onready var players: Players = $Players as Players
@onready var grid: Grid = $Grid as Grid
@onready var blur: Blur = $Blur as Blur

const GAME_SAVE_PATH: String = "user://game.save"

static var is_need_to_reset: bool = false

func _ready() -> void:
	if is_need_to_reset:
		is_need_to_reset = false
		
		_save()
	else:
		_load()
		
	players.detect_active_player()
	grid.connnect_to_mark_pressed(_on_mark_pressed)
	blur.continue_pressed.connect(_on_continue_pressed)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("open_menu"):
		_save()
		
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
func _on_mark_pressed(mark: Mark) -> void:
	mark.active(players.get_active_player_name())
	
	if grid.is_all_marks_used():
		blur.active()
	elif grid.is_shown_win_match_line():
		players.plus_one_score_to_active_player()
		blur.active()
	else:
		players.change_active_player()
		
func _on_continue_pressed():
	players.change_active_player()
	
	grid.reset()
	blur.deactive()
	
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
		"players": players.get_dict(),
		"grid": grid.get_dict(),
		"blur": blur.get_dict(),
	}
	
func load_dict(dict: Dictionary) -> void:
	if dict.has("players"):
		players.load_dict(dict.get("players") as Dictionary)
		
	if dict.has("grid"):
		grid.load_dict(dict.get("grid") as Dictionary)
		
	if dict.has("blur"):
		blur.load_dict(dict.get("blur") as Dictionary)
	
