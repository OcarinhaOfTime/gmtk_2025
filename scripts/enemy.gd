extends Area2D
@export var speed = 200.0

@onready var player = get_tree().get_current_scene().get_node("%player")
var begun = false
@onready var audio_player = $audio_player

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
	$AnimatedSprite2D.blink_red()

func on_death():
	speed = 0
	audio_player.play_once(1)
	$AnimatedSprite2D.fade_out(.8)
	#set_process_mode(Node.PROCESS_MODE_DISABLED)
	monitoring = false
	await TweenHandler.wait_secs(2)
	queue_free()



func _physics_process(delta: float) -> void:
	if not begun:
		begun = abs(player.position.x - position.x) < 400
		return

	position += Vector2(-1, 0) * speed * delta
