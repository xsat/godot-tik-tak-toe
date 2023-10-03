extends Node2D

class_name Grid

var _marks: Dictionary
var _match_lines: Dictionary

func _ready():
	_marks = {
		"0_0": $Marks/Mark_0_0, "0_1": $Marks/Mark_0_1, "0_2": $Marks/Mark_0_2,
		"1_0": $Marks/Mark_1_0, "1_1": $Marks/Mark_1_1, "1_2": $Marks/Mark_1_1,
		"2_0": $Marks/Mark_2_0, "2_1": $Marks/Mark_2_1, "2_2": $Marks/Mark_2_2,
	}
	
	_match_lines = {
		"first_horizontal": $MatchLines/MatchLine_First_Horizontal,
		"second_horizontal": $MatchLines/MatchLine_Second_Horizontal,
		"third_horizontal": $MatchLines/MatchLine_Third_Horizontal,
		"first_vertical": $MatchLines/MatchLine_First_Vertical,
		"second_vertical": $MatchLines/MatchLine_Second_Vertical,
		"third_vertical": $MatchLines/MatchLine_Third_Vertical,
		"falling_diagonal": $MatchLines/MatchLine_Falling_Diagonal,
		"rising_diagonal": $MatchLines/MatchLine_Rising_Diagonal,
	}
	
func connnect_to_mark_pressed(callable: Callable) -> void:
	for key in _marks:
		var mark: Mark = _marks[key]
		
		_marks[key].mark_pressed.connect(callable)

func is_all_marks_used() -> bool:
	var first_horizontal: MatchLine = _match_lines["first_horizontal"]
	var second_horizontal: MatchLine = _match_lines["second_horizontal"]
	var third_horizontal: MatchLine = _match_lines["third_horizontal"]
	
	return first_horizontal.is_marks_used() && second_horizontal.is_marks_used() && third_horizontal.is_marks_used()
	
func is_shown_win_match_line() -> bool:
	for key in _match_lines:
		var match_line: MatchLine = _match_lines[key]
		
		if match_line.is_marks_used() && match_line.is_same_values():
			match_line.visible = true
			
			return true
				
	return false
	
func reset() -> void:
	for key in _match_lines:
		_match_lines[key].visible = false
		
	for key in _marks:
		_marks[key].deactive()
	
func get_dict() -> Dictionary:
	var dict: Dictionary = {
		"marks": {},
		"match_lines": {},
	}
	
	for key in _marks:
		var mark: Mark = _marks[key]
		dict["marks"][key] = mark.get_dict()
	
	for key in _match_lines:
		var match_line: MatchLine = _match_lines[key]
		dict["match_lines"][key] = match_line.get_dict()
	
	return dict
	
func load_dict(dict: Dictionary) -> void:
	if dict.has("marks"):
		var marks: Dictionary = dict.get("marks")
#		
		for key in _marks:
			if marks.has(key):
				_marks[key].load_dict(marks.get(key))
	
	if dict.has("match_lines"):
		var match_lines: Dictionary = dict.get("match_lines")
		
		for key in _match_lines:
			if match_lines.has(key):
				_match_lines[key].load_dict(match_lines.get(key))
	
