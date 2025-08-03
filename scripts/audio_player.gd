class_name  AudioPlayer
extends AudioStreamPlayer2D

var streamlist = []

func _ready() -> void:
	for i in range(stream.stream_count):
		streamlist.append(stream.get_list_stream(i))

func play_once(k):
	stream = streamlist[k]
	play()
