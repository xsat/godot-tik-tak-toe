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

const NONE_WIN_POSITION: int = 0
const FIRST_HORIZONTAL_WIN_POSITION: int = 1
const SECOND_HORIZONTAL_WIN_POSITION: int = 2
const THIRD_HORIZONTAL_WIN_POSITION: int = 3
const FISRT_VERTICAL_WIN_POSITION: int = 4
const SECOND_VERTICALL_WIN_POSITION: int = 5
const THIRD_VERTICAL_WIN_POSITION: int = 6
const FALLING_DIAGONAL_WIN_POSITION: int = 7
const RISING_DIAGONAL_WIN_POSITION: int = 8

var active_scored_player: ScoredPlayer

func _ready() -> void:
	_change_active_player()
	
	mark_0_0.mark_pressed.connect(_on_mark_pressed)
	mark_0_1.mark_pressed.connect(_on_mark_pressed)
	mark_0_2.mark_pressed.connect(_on_mark_pressed)
	
	mark_1_0.mark_pressed.connect(_on_mark_pressed)
	mark_1_1.mark_pressed.connect(_on_mark_pressed)
	mark_1_2.mark_pressed.connect(_on_mark_pressed)

	mark_2_0.mark_pressed.connect(_on_mark_pressed)
	mark_2_1.mark_pressed.connect(_on_mark_pressed)
	mark_2_2.mark_pressed.connect(_on_mark_pressed)
	
func _on_mark_pressed(mark: Mark) -> void:
	mark.active(active_scored_player.player_name)
	
	var last_win_position: int = _get_player_win_positiion();
	if last_win_position == NONE_WIN_POSITION:
		_change_active_player()
	else:
		active_scored_player.plus_one_score()
		
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
		
	return NONE_WIN_POSITION
	
func _is_same_value(mark_a: Mark, mark_b: Mark, mark_c: Mark) -> bool:
	if !_is_makrs_used(mark_a, mark_b, mark_c):
		return false
	
	return mark_a.text.text == mark_b.text.text and mark_b.text.text == mark_c.text.text

func _is_makrs_used(mark_a: Mark, mark_b: Mark, mark_c: Mark) -> bool:
	return mark_a.text.visible && mark_b.text.visible && mark_c.text.visible
