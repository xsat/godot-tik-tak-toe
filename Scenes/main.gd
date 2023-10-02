extends Node

class_name Main

func _on_new_game_pressed():
	Game.is_need_to_reset = true
	
	_load_game()
	
func _on_continue_pressed():
	_load_game()

func _on_exit_pressed():
	get_tree().quit()

func _load_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
