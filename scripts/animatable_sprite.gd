extends AnimatedSprite2D

var color: Color:
	set(v):
		material.set_shader_parameter("color", v) 
	get:
		return material.get_shader_parameter('color')

var original_color
var target_color

func _ready():
	original_color = color
	var unique_material := material.duplicate()
	material = unique_material

func blink_red():
	target_color = Color.RED
	return TweenHandler.tween_blink(.5, blink_step)

func blink_ghost(d):
	color = Color(1, 1, 1, .33)
	var finish = TweenHandler.wait_secs(d, func (): color = original_color)
	
	return finish

func fade_out(d):
	target_color = Color.TRANSPARENT
	return TweenHandler.tween_func(d, func (t): color = lerp(original_color, target_color, t))

func blink(d:float, c:Color):
	target_color = c
	return TweenHandler.tween_blink(d, blink_step)

func blink_step(t):
	color = lerp(original_color, target_color, t ** 4)
