extends  Node

signal on_accept()
signal on_cancel()

var action_map = {
	'accept': on_accept,
	'cancel': on_cancel,
}


func get_move():
	var v = Input.get_vector(
		"move_left", 'move_right', 'move_down', 'move_up')
	
	return v

func _input(event):
	for k in action_map:
		if event.is_action_pressed(k):
			action_map[k].emit()
