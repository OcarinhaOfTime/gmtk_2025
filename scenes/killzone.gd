extends Area2D

func _ready():
	body_entered.connect(on_hit)
	
func on_hit(b):
	if b.has_node('HealthComponent'):
		var hc = b.get_node('HealthComponent')
		hc.take_damage(666)
