extends Node

class_name Main

@onready var local_player_x = $LocalPlayer_X as LocalPlayer
@onready var local_player_o = $LocalPlayer_O as LocalPlayer
@onready var mark_1_1 = $Grid/Mark_1_1 as Mark
@onready var mark_1_2 = $Grid/Mark_1_2 as Mark
@onready var mark_1_3 = $Grid/Mark_1_3 as Mark
@onready var mark_2_1 = $Grid/Mark_2_1 as Mark
@onready var mark_2_2 = $Grid/Mark_2_2 as Mark
@onready var mark_2_3 = $Grid/Mark_2_3 as Mark
@onready var mark_3_1 = $Grid/Mark_3_1 as Mark
@onready var mark_3_2 = $Grid/Mark_3_2 as Mark
@onready var mark_3_3 = $Grid/Mark_3_3 as Mark

var player_value: String

func _ready() -> void:
	local_player_x.deactive()
	local_player_o.active()
	player_value = local_player_o.text
	
	mark_1_1.mark_pressed.connect(_on_mark_pressed)
	mark_1_2.mark_pressed.connect(_on_mark_pressed)
	mark_1_3.mark_pressed.connect(_on_mark_pressed)
	mark_2_1.mark_pressed.connect(_on_mark_pressed)
	mark_2_2.mark_pressed.connect(_on_mark_pressed)
	mark_2_3.mark_pressed.connect(_on_mark_pressed)
	mark_3_1.mark_pressed.connect(_on_mark_pressed)
	mark_3_2.mark_pressed.connect(_on_mark_pressed)
	mark_3_3.mark_pressed.connect(_on_mark_pressed)
	
func _on_mark_pressed(mark: Mark) -> void:
	local_player_x.active()
	local_player_o.deactive()
	player_value = local_player_x.text
	
	print(mark.x)
	print(mark.y)
	print("Grid:_on_mark_pressed")
	mark.active(player_value)
	
