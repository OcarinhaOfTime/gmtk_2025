extends Camera2D
@onready var player = %player

func _ready():
	limit_left = int(%edge_start.global_position.x)
	limit_right = int(%edge_end.global_position.x)

func _process(_delta: float) -> void:
	position.x = player.position.x
