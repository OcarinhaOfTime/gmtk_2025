extends Area2D



func _ready():
	body_entered.connect(on_hit)
	
func on_hit(b):
	if b.is_in_group('player'):
		b.on_entereed_new_level()
