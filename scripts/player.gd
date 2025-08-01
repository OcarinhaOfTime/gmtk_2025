extends CharacterBody2D


var speed = 120.0
var jump_vel = -320.0


@onready var anim = $AnimatedSprite2D
var was_on_air = false
var timer = 0
var is_attacking = false
var idle_timer = 0
var is_idle_animing = false
var sprint_mod =  1.9
var speed_mod = 1.0
var fps_mod = 1.0

func _ready() -> void:
	InputWrapper.on_jump.connect(jump)
	InputWrapper.on_attack.connect(attack)
	InputWrapper.on_shoot.connect(func (): print('pew'))

	anim.animation_finished.connect(on_animation_end)

func attack():
	idle_timer = 0
	if is_attacking:
		return
	is_attacking = true
	anim.play('attack')

func on_animation_end():
	if is_attacking:
		is_attacking=false

func jump():
	if is_on_floor():
		velocity.y = jump_vel

func _physics_process(delta: float) -> void:	
	var b = InputWrapper.is_pressed('dash')
	speed_mod = sprint_mod if b else 1.0
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = InputWrapper.get_move().x
	if is_attacking and is_on_floor():
		direction = 0
	
	if direction:
		velocity.x = direction * speed * speed_mod
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	handle_animation(delta)

func handle_animation(delta):
	idle_timer += delta
	if velocity.x != 0:
		idle_timer = 0
		anim.flip_h = velocity.x < 0

	if is_attacking:
		return

	if is_on_floor() and was_on_air:
		timer += delta
		anim.play('land')
		if timer > .1:
			was_on_air = false


	elif is_on_floor():
		if abs(velocity.x) > 0:
			var k = 'run' if speed_mod <= 1 else 'sprint'
			anim.play(k)
		else:
			if idle_timer < 3:
				anim.play('idle')	
			elif idle_timer < 5:
				anim.play('idle_anim')
			else:
				idle_timer = 0

	else:
		idle_timer = 0
		timer = 0
		was_on_air = true
		if velocity.y < 0:
			anim.play('jump')
		else:
			anim.play('fall')
		

	
