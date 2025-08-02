extends Control
@onready var hearts = $panel/hbox.get_children()
@onready var player_health = %player.get_node('HealthComponent')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_health.on_take_damage.connect(update_health)


func update_health():
	for i in range(len(hearts)):
		hearts[i].visible = i < player_health.health 
