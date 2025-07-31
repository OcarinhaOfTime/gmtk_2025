extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
@onready var anim = $AnimatedSprite2D
var was_on_air = false
var timer = 0
var is_attacking = false
var idle_timer = 0
var is_idle_animing = false

func _ready() -> void:
	InputWrapper.on_jump.connect(jump)
	InputWrapper.on_attack.connect(attack)

	anim.animation_finished.connect(on_animation_end)

func attack():
	if is_attacking:
		return
	is_attacking = true
	anim.play('attack')

func on_animation_end():
	if is_attacking:
		is_attacking=false

func jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = InputWrapper.get_move().x
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

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
			anim.play('run')
		else:
			if idle_timer < 3:
				anim.play('idle')	
			elif idle_timer < 5:
				anim.play('idle_anim')
			else:
				idle_timer = 0

	else:
		timer = 0
		was_on_air = true
		if velocity.y < 0:
			anim.play('jump')
		else:
			anim.play('fall')
		

	
