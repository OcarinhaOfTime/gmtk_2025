extends Node

@onready var music := AudioStreamPlayer.new()

@onready var player = get_tree().get_current_scene().get_node("%player")
@onready var game_over_panel =  get_tree().get_current_scene().get_node("%game_over_panel")
@onready var fade_panel =  get_tree().get_current_scene().get_node("%fade_panel")

@onready var cam = get_tree().get_current_scene().get_node('%main_camera')
@onready var level_manager = get_tree().get_current_scene().get_node('%level_manager')

var current_level = 0
var current_stage = null

func _ready() -> void:
	print('am I here again???')
	Engine.max_fps = 60
	add_child(music)
	music.stream = preload("res://audio/music/Spooky Town.mp3")
	music.bus = "Music"

	player.on_death.connect(game_over)
	player.entered_new_level.connect(next_level)

	await get_tree().create_timer(0.1).timeout

	current_level = clamp(0, 2, level_manager.first_level -1)

	current_stage = level_manager.load_level(current_level)
	cam.setup_lims(current_stage)

	var s = fade_panel.get_theme_stylebox('Panel')
	var new_style = s.duplicate() 
	new_style.bg_color = Color.RED
	fade_panel.add_theme_stylebox_override("Panel", new_style)

func game_over():
	print('Game manager: u done boy')
	await TweenHandler.wait_secs(1)
	game_over_panel.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('reload_game'):
		reload_game()

func next_level():
	current_level += 1
	print('next level ' + str(current_level))
	call_deferred('reload_game')


func reload_game():
	print('reloading!!!')
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	await get_tree().create_timer(0.1).timeout
	refresh_refs()
	
	
func refresh_refs():
	var cs = get_tree().get_current_scene()

	game_over_panel = cs.get_node("%game_over_panel")
	fade_panel = cs.get_node("%fade_panel")
	player = cs.get_node("%player")
	cam = cs.get_node("%main_camera")
	level_manager = cs.get_node("%level_manager")

	current_stage = level_manager.load_level(current_level)

	player.on_death.connect(game_over)
