extends  Node

signal on_accept()
signal on_cancel()
signal on_jump()
signal on_attack()
signal on_shoot()
signal  on_dash_released()
signal on_dash()

var action_map = {
	'accept': on_accept,
	'cancel': on_cancel,
	'jump': on_jump,
	'attack': on_attack,
	'shoot': on_shoot,
	'dash': on_dash
}

var release_map = {
	'dash': on_dash_released,
}


func get_move():
	var v = Input.get_vector(
		"move_left", 'move_right', 'move_down', 'move_up')
	
	return v

func is_pressed(k):
	return Input.is_action_pressed(k)

func is_just_pressed(k):
	return Input.is_action_just_pressed(k)

func is_released(k):
	return Input.is_action_just_released(k)

func _input(event):
	for k in action_map:
		if event.is_action_pressed(k):
			action_map[k].emit()

	for k in release_map:
		if event.is_action_released(k):
			release_map[k].emit()
