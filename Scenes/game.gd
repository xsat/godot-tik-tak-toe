extends Node

class_name Game

@onready var scored_player_x: ScoredPlayer = $ScoredPlayers/ScoredPlayer_X as ScoredPlayer
@onready var scored_player_o: ScoredPlayer = $ScoredPlayers/ScoredPlayer_O as ScoredPlayer

@onready var mark_0_0: Mark = $Grid/Mark_0_0 as Mark
@onready var mark_0_1: Mark = $Grid/Mark_0_1 as Mark
@onready var mark_0_2: Mark = $Grid/Mark_0_2 as Mark
@onready var mark_1_0: Mark = $Grid/Mark_1_0 as Mark
@onready var mark_1_1: Mark = $Grid/Mark_1_1 as Mark
@onready var mark_1_2: Mark = $Grid/Mark_1_2 as Mark
@onready var mark_2_0: Mark = $Grid/Mark_2_0 as Mark
@onready var mark_2_1: Mark = $Grid/Mark_2_1 as Mark
@onready var mark_2_2: Mark = $Grid/Mark_2_2 as Mark

@onready var match_line_first_horizontal: MatchLine = $MatchLines/MatchLine_First_Horizontal as MatchLine
@onready var match_line_second_horizontal: MatchLine = $MatchLines/MatchLine_Second_Horizontal as MatchLine
@onready var match_line_third_horizontal: MatchLine = $MatchLines/MatchLine_Third_Horizontal as MatchLine
@onready var match_line_first_vertical: MatchLine = $MatchLines/MatchLine_First_Vertical as MatchLine
@onready var match_line_second_vertical: MatchLine = $MatchLines/MatchLine_Second_Vertical as MatchLine
@onready var match_line_third_vertical: MatchLine = $MatchLines/MatchLine_Third_Vertical as MatchLine
@onready var match_line_falling_diagonal: MatchLine = $MatchLines/MatchLine_Falling_Diagonal as MatchLine
@onready var match_line_rising_diagonal: MatchLine = $MatchLines/MatchLine_Rising_Diagonal as MatchLine

@onready var blur: ColorRect = $blur as ColorRect


const DRAW_WIN_POSITION: int = -1
const NONE_WIN_POSITION: int = 0
const FIRST_HORIZONTAL_WIN_POSITION: int = 1
const SECOND_HORIZONTAL_WIN_POSITION: int = 2
const THIRD_HORIZONTAL_WIN_POSITION: int = 3
const FISRT_VERTICAL_WIN_POSITION: int = 4
const SECOND_VERTICALL_WIN_POSITION: int = 5
const THIRD_VERTICAL_WIN_POSITION: int = 6
const FALLING_DIAGONAL_WIN_POSITION: int = 7
const RISING_DIAGONAL_WIN_POSITION: int = 8

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
	
	mark_0_0.mark_pressed.connect(_on_mark_pressed)
	mark_0_1.mark_pressed.connect(_on_mark_pressed)
	mark_0_2.mark_pressed.connect(_on_mark_pressed)
	
	mark_1_0.mark_pressed.connect(_on_mark_pressed)
	mark_1_1.mark_pressed.connect(_on_mark_pressed)
	mark_1_2.mark_pressed.connect(_on_mark_pressed)
	
	mark_2_0.mark_pressed.connect(_on_mark_pressed)
	mark_2_1.mark_pressed.connect(_on_mark_pressed)
	mark_2_2.mark_pressed.connect(_on_mark_pressed)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("open_menu"):
		_save()
		
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
func _on_mark_pressed(mark: Mark) -> void:
	mark.active(active_scored_player.player_name)
	
	var last_win_position: int = _get_player_win_positiion();
	if last_win_position == NONE_WIN_POSITION:
		_change_active_player()
	else:
		if last_win_position == FIRST_HORIZONTAL_WIN_POSITION:
			match_line_first_horizontal.visible = true
		elif last_win_position == SECOND_HORIZONTAL_WIN_POSITION:
			match_line_second_horizontal.visible = true
		elif last_win_position == THIRD_HORIZONTAL_WIN_POSITION:
			match_line_third_horizontal.visible = true
		elif last_win_position == FISRT_VERTICAL_WIN_POSITION:
			match_line_first_vertical.visible = true
		elif last_win_position == SECOND_VERTICALL_WIN_POSITION:
			match_line_second_vertical.visible = true
		elif last_win_position == THIRD_VERTICAL_WIN_POSITION:
			match_line_third_vertical.visible = true
		elif last_win_position == FALLING_DIAGONAL_WIN_POSITION:
			match_line_falling_diagonal.visible = true
		elif last_win_position == RISING_DIAGONAL_WIN_POSITION:
			match_line_rising_diagonal.visible = true
			
		if last_win_position != DRAW_WIN_POSITION:
			active_scored_player.plus_one_score()
		
		blur.visible = true
		
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
	if _is_same_value(mark_0_0, mark_0_1, mark_0_2):
		return FIRST_HORIZONTAL_WIN_POSITION
		
	if _is_same_value(mark_1_0, mark_1_1, mark_1_2):
		return SECOND_HORIZONTAL_WIN_POSITION
		
	if _is_same_value(mark_2_0, mark_2_1, mark_2_2):
		return THIRD_HORIZONTAL_WIN_POSITION
		
	if _is_same_value(mark_0_0, mark_1_0, mark_2_0):
		return FISRT_VERTICAL_WIN_POSITION
		
	if _is_same_value(mark_0_1, mark_1_1, mark_2_1):
		return SECOND_VERTICALL_WIN_POSITION
		
	if _is_same_value(mark_0_2, mark_1_2, mark_2_2):
		return THIRD_VERTICAL_WIN_POSITION
		
	if _is_same_value(mark_0_0, mark_1_1, mark_2_2):
		return FALLING_DIAGONAL_WIN_POSITION
		
	if _is_same_value(mark_2_0, mark_1_1, mark_0_2):
		return RISING_DIAGONAL_WIN_POSITION
		
	if _is_makrs_used(mark_0_0, mark_0_1, mark_0_2):
		if _is_makrs_used(mark_1_0, mark_1_1, mark_1_2):
			if _is_makrs_used(mark_2_0, mark_2_1, mark_2_2):
				return DRAW_WIN_POSITION
		
	return NONE_WIN_POSITION
	
func _is_same_value(mark_a: Mark, mark_b: Mark, mark_c: Mark) -> bool:
	if !_is_makrs_used(mark_a, mark_b, mark_c):
		return false
	
	return mark_a.text.text == mark_b.text.text and mark_b.text.text == mark_c.text.text
	
func _is_makrs_used(mark_a: Mark, mark_b: Mark, mark_c: Mark) -> bool:
	return mark_a.text.visible && mark_b.text.visible && mark_c.text.visible
	
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
		"marks": {
			"0_0": mark_0_0.get_dict(),
			"0_1": mark_0_1.get_dict(),
			"0_2": mark_0_2.get_dict(),
			"1_0": mark_1_0.get_dict(),
			"1_1": mark_1_1.get_dict(),
			"1_2": mark_1_2.get_dict(),
			"2_0": mark_2_0.get_dict(),
			"2_1": mark_2_1.get_dict(),
			"2_2": mark_2_2.get_dict(),
		},
		"match_lines": {
			"first_horizontal": match_line_first_horizontal.get_dict(),
			"second_horizontal": match_line_second_horizontal.get_dict(),
			"third_horizontal": match_line_third_horizontal.get_dict(),
			"first_vertical": match_line_first_vertical.get_dict(),
			"second_vertical": match_line_second_vertical.get_dict(),
			"third_vertical": match_line_third_vertical.get_dict(),
			"falling_diagonal": match_line_falling_diagonal.get_dict(),
			"rising_diagonal": match_line_rising_diagonal.get_dict(),
		},
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
		
	if dict.has("marks"):
		var marks: Dictionary = dict.get("marks") as Dictionary
		
		if marks.has("0_0"):
			mark_0_0.load_dict(marks.get("0_0") as Dictionary)
			
		if marks.has("0_1"):
			mark_0_1.load_dict(marks.get("0_1") as Dictionary)
			
		if marks.has("0_2"):
			mark_0_2.load_dict(marks.get("0_2") as Dictionary)
			
		if marks.has("1_0"):
			mark_1_0.load_dict(marks.get("1_0") as Dictionary)
			
		if marks.has("1_1"):
			mark_1_1.load_dict(marks.get("1_1") as Dictionary)
			
		if marks.has("1_2"):
			mark_1_2.load_dict(marks.get("1_2") as Dictionary)
			
		if marks.has("2_0"):
			mark_2_0.load_dict(marks.get("2_0") as Dictionary)
			
		if marks.has("2_1"):
			mark_2_1.load_dict(marks.get("2_1") as Dictionary)
			
		if marks.has("2_2"):
			mark_2_2.load_dict(marks.get("2_2") as Dictionary)
			
	if dict.has("match_lines"):
		var match_lines: Dictionary = dict.get("match_lines") as Dictionary
		
		if match_lines.has("first_horizontal"):
			match_line_first_horizontal.load_dict(match_lines.get("first_horizontal") as Dictionary)
			
		if match_lines.has("second_horizontal"):
			match_line_second_horizontal.load_dict(match_lines.get("second_horizontal") as Dictionary)
			
		if match_lines.has("third_horizontal"):
			match_line_third_horizontal.load_dict(match_lines.get("third_horizontal") as Dictionary)
			
		if match_lines.has("first_vertical"):
			match_line_first_vertical.load_dict(match_lines.get("first_vertical") as Dictionary)
			
		if match_lines.has("second_vertical"):
			match_line_second_vertical.load_dict(match_lines.get("second_vertical") as Dictionary)
			
		if match_lines.has("third_vertical"):
			match_line_third_vertical.load_dict(match_lines.get("third_vertical") as Dictionary)
			
		if match_lines.has("falling_diagonal"):
			match_line_falling_diagonal.load_dict(match_lines.get("falling_diagonal") as Dictionary)
			
		if match_lines.has("rising_diagonal"):
			match_line_rising_diagonal.load_dict(match_lines.get("rising_diagonal") as Dictionary)
			
func _on_continue_pressed():
	_change_active_player()
	
	match_line_first_horizontal.visible = false
	match_line_second_horizontal.visible = false
	match_line_third_horizontal.visible = false
	match_line_first_vertical.visible = false
	match_line_second_vertical.visible = false
	match_line_third_vertical.visible = false
	match_line_falling_diagonal.visible = false
	match_line_rising_diagonal.visible = false
	
	mark_0_0.deactive()
	mark_0_1.deactive()
	mark_0_2.deactive()
	mark_1_0.deactive()
	mark_1_1.deactive()
	mark_1_2.deactive()
	mark_2_0.deactive()
	mark_2_1.deactive()
	mark_2_2.deactive()
	
	blur.visible = false
	
