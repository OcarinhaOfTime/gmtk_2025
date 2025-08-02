extends Area2D
@export var speed = 200.0

func _ready():
	body_entered.connect(on_hit)
	$HealthComponent.on_death.connect(queue_free)
	
func on_hit(b):
	if b.has_node('HealthComponent'):
		var hc = b.get_node('HealthComponent')
		hc.take_damage(1)

func _physics_process(delta: float) -> void:
	position += Vector2(-1, 0) * speed * delta
