extends Node

class_name Main

@onready var grid = $Grid as Grid
@onready var local_player_x = $LocalPlayer_X as LocalPlayer
@onready var local_player_o = $LocalPlayer_O as LocalPlayer

func _ready():
	local_player_x.deactive()
	local_player_o.deactive()
