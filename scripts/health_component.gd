class_name HealthComponent

extends Node2D

signal on_take_damage()
signal on_death()

var health: int = 3
@export var max_health: int = 3
var has_iframes = false

func _ready():
	health = max_health

func take_damage(d):
	if has_iframes:
		return
		
	if health <= 0:
		return
		
	health = max(0, health - d)
	if health > 0:
		on_take_damage.emit()
	
	if health <= 0:
		on_death.emit()
