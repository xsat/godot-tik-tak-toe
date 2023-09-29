extends Button

class_name Mark

signal mark_pressed(mark: Mark)

@export var x = 0
@export var y = 0

func _on_pressed():
	print("Mark:_on_pressed")
	mark_pressed.emit(self)
