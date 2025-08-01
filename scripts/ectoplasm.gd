extends Area2D
@onready var player = %player

@export var pull_speed = 10


func _ready() -> void:
	print("excuuuuuuuuuuse me?")
	body_entered.connect(func (b): player.ectoplasm = self)
	body_exited.connect(func (b): player.ectoplasm = null)

func process_gravity(p, delta):
	var d = (position - p.position).normalized()
	var m = position.distance_to(p.position)
	p.velocity = d * pull_speed * delta * m
	


