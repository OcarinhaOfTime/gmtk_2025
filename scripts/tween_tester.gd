extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('accept'):
		test_tween()

func test_tween():
	print('tweenining this shit')
	#TweenHandler.tween_blink(1, func (t): print(t))
	var asp = $enemy/AnimatedSprite2D
	print('start')
	await asp.blink_ghost(2)
	print('end')