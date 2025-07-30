extends Node2D

@export var speed: int = 100

func _ready() -> void:
	InputWrapper.on_accept.connect(func (): print('accepted'))


func _process(delta: float) -> void:
	var v = InputWrapper.get_move()
	if v.length() <= 0:
		return
	
	v.y *= -1
	position += v * delta * speed
	var r = atan2(v.y, v.x) - PI / 2
	rotation = r