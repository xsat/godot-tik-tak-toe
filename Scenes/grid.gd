extends Node2D

class_name Grid

@onready var mark_1_1 = $grid_body/Mark_1_1 as Mark
@onready var mark_1_2 = $grid_body/Mark_1_2 as Mark
@onready var mark_1_3 = $grid_body/Mark_1_3 as Mark
@onready var mark_2_1 = $grid_body/Mark_2_1 as Mark
@onready var mark_2_2 = $grid_body/Mark_2_2 as Mark
@onready var mark_2_3 = $grid_body/Mark_2_3 as Mark
@onready var mark_3_1 = $grid_body/Mark_3_1 as Mark
@onready var mark_3_2 = $grid_body/Mark_3_2 as Mark
@onready var mark_3_3 = $grid_body/Mark_3_3 as Mark

func _ready():
	print("Grid:_ready")
	
	mark_1_1.mark_pressed.connect(_on_mark_pressed)
	mark_1_2.mark_pressed.connect(_on_mark_pressed)
	mark_1_3.mark_pressed.connect(_on_mark_pressed)
	mark_2_1.mark_pressed.connect(_on_mark_pressed)
	mark_2_2.mark_pressed.connect(_on_mark_pressed)
	mark_2_3.mark_pressed.connect(_on_mark_pressed)
	mark_3_1.mark_pressed.connect(_on_mark_pressed)
	mark_3_2.mark_pressed.connect(_on_mark_pressed)
	mark_3_3.mark_pressed.connect(_on_mark_pressed)
	
func _on_mark_pressed(mark: Mark):
	print(mark.x)
	print(mark.y)
	print("Grid:_on_mark_pressed")
