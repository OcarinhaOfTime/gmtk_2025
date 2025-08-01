extends Camera2D
@onready var player = %player


func _process(_delta: float) -> void:
	position.x = player.position.x
