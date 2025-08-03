extends Node

@onready var music := AudioStreamPlayer.new()

@onready var player = get_tree().get_current_scene().get_node("%player")
@onready var game_over_panel =  get_tree().get_current_scene().get_node("%game_over_panel")

func _ready() -> void:
	Engine.max_fps = 60
	add_child(music)
	music.stream = preload("res://audio/music/Spooky Town.mp3")
	music.bus = "Music"
	#music.play()
	player.on_death.connect(game_over)

func game_over():
	print('Game manager: u done boy')
	await TweenHandler.wait_secs(1)
	game_over_panel.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('reload_game'):
		reload_game()


func reload_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

	await get_tree().create_timer(0.1).timeout
	
	game_over_panel = get_tree().get_current_scene().get_node("%game_over_panel")
	player = get_tree().get_current_scene().get_node("%player")
	player.on_death.connect(game_over)
