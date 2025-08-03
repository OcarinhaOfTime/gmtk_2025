extends Node2D

@onready var levels = [
	preload('res://scenes/stages/stage_1.tscn'),
	preload('res://scenes/stages/stage_2.tscn'),
	preload('res://scenes/stages/stage_3.tscn'),
]

var loaded_level = null
@export var first_level : int = 1

func load_level(k):
	if loaded_level != null:
		loaded_level.queue_free()

	loaded_level = levels[k].instantiate()
	get_tree().get_current_scene().add_child(loaded_level)
	return loaded_level
