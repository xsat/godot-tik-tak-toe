extends Node2D

class_name Players

@onready var scored_player_x: ScoredPlayer = $ScoredPlayer_X as ScoredPlayer
@onready var scored_player_o: ScoredPlayer = $ScoredPlayer_O as ScoredPlayer

var _active_scored_player: ScoredPlayer

func get_active_player_name() -> String:
	return _active_scored_player.player_name

func plus_one_score_to_active_player() -> void:
	if _active_scored_player:
		_active_scored_player.plus_one_score()
	
func detect_active_player() -> void:
	if scored_player_o.is_player_active:
		_active_scored_player = scored_player_o
		scored_player_x.deactive()
		scored_player_o.active()
	else:
		_active_scored_player = scored_player_x
		scored_player_x.active()
		scored_player_o.deactive()
		
func change_active_player() -> void:
	if _active_scored_player && _active_scored_player.player_name == scored_player_x.player_name:
		scored_player_x.deactive()
		scored_player_o.active()
		_active_scored_player = scored_player_o
	else:
		scored_player_x.active()
		scored_player_o.deactive()
		_active_scored_player = scored_player_x
		
func get_dict() -> Dictionary:
	return {
		"x": scored_player_x.get_dict(),
		"o": scored_player_o.get_dict(),
	}
	
func load_dict(dict: Dictionary) -> void:
	if dict.has("x"):
		scored_player_x.load_dict(dict.get("x") as Dictionary)
		
	if dict.has("o"):
		scored_player_o.load_dict(dict.get("o") as Dictionary)
	
