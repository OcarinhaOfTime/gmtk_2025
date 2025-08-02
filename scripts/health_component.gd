class_name HealthComponent

extends Node2D

signal on_take_damage()
signal on_death()

var health: int = 3
@export var max_health: int = 3

func _ready():
	health = max_health

func take_damage(d):
	print('damage on ' + get_parent().name)
	if health <= 0:
		return
		
	health = max(0, health - d)
	on_take_damage.emit()
	
	if health <= 0:
		on_death.emit()
