extends Node

class_name Saver

const GAME_SAVE_PATH: String = "user://game.save"

func save_game(game: Game) -> void:
	var json_string: String = JSON.stringify(game.get_dict())
	
	var save_game_file: FileAccess = FileAccess.open(GAME_SAVE_PATH, FileAccess.WRITE)
	save_game_file.store_line(json_string)
	save_game_file.close()
	
func load_game(game: Game) -> void:
	var save_game_file: FileAccess = FileAccess.open(GAME_SAVE_PATH, FileAccess.READ)
	var saved_dict: Dictionary = JSON.parse_string(save_game_file.get_line()) as Dictionary
	save_game_file.close()
	
	game.load_dict(saved_dict)
	
