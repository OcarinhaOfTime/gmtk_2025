extends CharacterBody2D


var speed = 120.0
var jump_vel = -320.0


@onready var anim = $AnimatedSprite2D
var was_on_air = false
var timer = 0
var is_attacking = false
var is_shooting = false
var idle_timer = 0
var is_idle_animing = false
var sprint_mod =  1.9
var speed_mod = 1.0

#var ectoplasm = null

@onready var animated_shot_scene = preload('res://scenes/animated_shot.tscn')

func _ready() -> void:
	InputWrapper.on_jump.connect(jump)
	InputWrapper.on_attack.connect(attack)
	InputWrapper.on_shoot.connect(shoot)

	InputWrapper.on_dash.connect(dash)
	InputWrapper.on_dash_released.connect(func (): speed_mod=1.0)

	anim.animation_finished.connect(on_animation_end)

func attack():
	idle_timer = 0
	if is_attacking:
		return
	is_attacking = true
	anim.play('attack')

func shoot():
	idle_timer = 0
	if is_shooting:
		return
	is_shooting = true
	anim.play('shoot')
	anim.offset.x = -16 if anim.flip_h else 16

	await wait_for_n_process_frames(12)

	var animated_shot = animated_shot_scene.instantiate()
	get_tree().root.add_child(animated_shot)
	var s = sign(anim.offset.x)
	animated_shot.shoot(self, s) 



func dash():
	if is_on_floor():
		speed_mod = sprint_mod

func on_animation_end():
	if is_attacking:
		is_attacking=false

	if is_shooting:
		is_shooting=false
		anim.play('idle')
		anim.offset.x = 0

func jump():
	if is_on_floor():
		velocity.y = jump_vel

func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()
	handle_animation(delta)

func movement(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = InputWrapper.get_move().x
	if (is_attacking or is_shooting) and is_on_floor():
		direction = 0
	
	if direction:
		velocity.x = direction * speed * speed_mod
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	

func handle_animation(delta):
	idle_timer += delta
	if velocity.x != 0:
		idle_timer = 0
		anim.flip_h = velocity.x < 0

	if is_attacking or is_shooting:
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
			else:
				is_idle_animing = true
				anim.play('idle_anim')

	else:
		idle_timer = 0
		timer = 0
		was_on_air = true
		if velocity.y < 0:
			anim.play('jump')
		else:
			anim.play('fall')
		

	
func wait_for_n_process_frames(n_frames: int):
	for i in range(n_frames):
		await get_tree().process_frame