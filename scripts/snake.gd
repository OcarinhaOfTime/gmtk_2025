extends Area2D
@export var speed = 200.0

@onready var player = get_tree().get_current_scene().get_node("%player")
var begun = false
@onready var audio_player = $audio_player
@onready var rl = $raycast_l
@onready var rr = $raycast_r
@onready var anim = $AnimatedSprite2D

var dir = -1

func _ready():
	body_entered.connect(on_hit)
	$HealthComponent.on_death.connect(on_death)
	$HealthComponent.on_take_damage.connect(on_take_damage)
	
func on_hit(b):
	if b.has_node('HealthComponent'):
		var hc = b.get_node('HealthComponent')
		hc.take_damage(1)

func on_take_damage():
	audio_player.play_once(0)
	anim.blink_red()

func on_death():
	speed = 0
	audio_player.play_once(1)
	anim.fade_out(.8)
	monitoring = false
	await TweenHandler.wait_secs(2)
	queue_free()



func _physics_process(delta: float) -> void:

	position += Vector2(dir, 0) * speed * delta
	if dir < 0:
		if not rl.is_colliding():
			dir *= -1
			anim.flip_h = true

	else:
		if not rr.is_colliding():
			dir *= -1
			anim.flip_h = false

