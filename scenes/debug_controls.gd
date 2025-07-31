extends Control

@onready var speed_slider = $panel/speed_setting/HSlider
@onready var speed_label = $panel/speed_setting/Label2
var speed:
	set(v):
		speed_slider.value = v
		speed_label.text = str(v)
		player.speed = v

@onready var jump_slider = $panel/jump_setting/HSlider
@onready var jump_label = $panel/jump_setting/Label2
var jump:
	set(v):
		jump_slider.value = v
		jump_label.text = str(v)
		player.jump_vel = -v

@onready var player = %player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = player.speed
	jump = -player.jump_vel

	speed_slider.value_changed.connect(func (v): speed = v)
	jump_slider.value_changed.connect(func (v): jump = v)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
