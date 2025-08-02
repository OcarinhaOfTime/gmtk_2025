extends Area2D

var speed = 350
var timer = 0
var dir = 1
var exploding = false
@onready var animated_shot = $animated_shot

func _ready() -> void:
	body_entered.connect(hit)
	area_entered.connect(hit)

func hit(b):
	if b.is_in_group('player'):
		return
	if b.has_node('HealthComponent'):
		b.get_node('HealthComponent').take_damage(1)

	speed = 0
	explode()

func shoot(node, d):
	dir = d
	var gps = node.global_position + Vector2(dir * 24, -10)
	global_position = gps
	animated_shot.play('shoot')

func explode():
	animated_shot.play('explode')
	await animated_shot.animation_finished
	queue_free()

func _physics_process(delta: float) -> void:
	timer += delta
	if timer > .35 and not exploding:
		exploding = true
		explode()

	if exploding:
		return
	global_position += Vector2(speed * delta * dir, 0)
	animated_shot.flip_h = dir < 0

	if position.x > 3000:
		print('proj deleting myself', self)
		queue_free()
