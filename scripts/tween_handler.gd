extends Node

func ping_pong(t: float, length: float = 1.0) -> float:
	var mod = fmod(t, length * 2.0)
	return length - abs(mod - length)

func blink(t, n):
	return abs(sin(t * PI * n))

func wait_secs(d, on_end=null):
	var tween = get_tree().create_tween()
	tween.tween_method(func (_t): pass, 0.0, 1.0, d)
	if on_end != null:
		tween.finished.connect(on_end)
	tween.play()
	return tween.finished


func tween_func(d, on_each, easet := Tween.EASE_IN_OUT, trans := Tween.TRANS_LINEAR):
	var tween = get_tree().create_tween()
	tween.tween_method(on_each, 0.0, 1.0, d).set_trans(trans).set_ease(easet)
	tween.play()
	return tween.finished

func tween_blink(d, on_each, n=1, easet := Tween.EASE_IN_OUT, trans := Tween.TRANS_LINEAR):
	var tween = get_tree().create_tween()
	tween.tween_method(func (t): on_each.call(blink(t, n)), 0.0, 1.0, d).set_trans(trans).set_ease(easet)
	tween.play()
	return tween.finished

func tween_pp(d, on_each, easet := Tween.EASE_IN_OUT, trans := Tween.TRANS_LINEAR):
	var tween = get_tree().create_tween()
	tween.tween_method(func (t): on_each.call(ping_pong(t)), 0.0, 1.0, d).set_trans(trans).set_ease(easet)
	tween.play()
	return tween.finished
