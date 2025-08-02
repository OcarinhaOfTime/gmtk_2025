extends Area2D
@onready var player = %player

@export var pull_speed = 400
@export var drag = .5

@onready var top = position + Vector2(0, -scale.y * $Sprite2D.texture.get_size().y * .2)
@onready var bottom = position + Vector2(0, scale.y * $Sprite2D.texture.get_size().y * .2)

var pull_force: Vector2 = Vector2(0, 0)
var momentum_force: Vector2 = Vector2(0, 0)

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
func on_body_entered(b):
	if b != player:
		return
	player.ectoplasm = self
	pull_force = Vector2(0, 0)
	momentum_force = b.velocity
	
func on_body_exited(b):
	if b != player:
		return
	player.ectoplasm = null
	pull_force = Vector2(0, 0)
	momentum_force = b.velocity
	player.velocity += momentum_force.normalized() * 100

func move_toward2d(from, to, amount):
	return Vector2(move_toward(from.x, to.x, amount), move_toward(from.y, to.y, amount))
	

func process_gravity(node, delta):
	var p = position
	var d = p - node.position
	pull_force += d.normalized() * pull_speed * delta
	
	momentum_force = lerp(momentum_force, Vector2(0, 0), delta * drag)
	node.velocity = pull_force + momentum_force
