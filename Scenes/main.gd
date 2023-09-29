extends Node

class_name Main

@onready var local_player_x: LocalPlayer = $LocalPlayers/LocalPlayer_X as LocalPlayer
@onready var local_player_o: LocalPlayer = $LocalPlayers/LocalPlayer_O as LocalPlayer

@onready var mark_0_0: Mark = $Grid/Mark_0_0 as Mark
@onready var mark_0_1: Mark = $Grid/Mark_0_1 as Mark
@onready var mark_0_2: Mark = $Grid/Mark_0_2 as Mark
@onready var mark_1_0: Mark = $Grid/Mark_1_0 as Mark
@onready var mark_1_1: Mark = $Grid/Mark_1_1 as Mark
@onready var mark_1_2: Mark = $Grid/Mark_1_2 as Mark
@onready var mark_2_0: Mark = $Grid/Mark_2_0 as Mark
@onready var mark_2_1: Mark = $Grid/Mark_2_1 as Mark
@onready var mark_2_2: Mark = $Grid/Mark_2_2 as Mark

var player_value: String = "~"

func _ready() -> void:
	print("Grid:_ready")
	
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
	mark.active(player_value)
	
	_change_active_player()
	
func _change_active_player() -> void:
	if player_value == local_player_x.text:
		local_player_x.deactive()
		local_player_o.active()
		player_value = local_player_o.text
	else:
		local_player_x.active()
		local_player_o.deactive()
		player_value = local_player_x.text
