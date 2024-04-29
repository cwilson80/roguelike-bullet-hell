extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# This handles unpausing the game
	await get_tree().create_timer(0.1).timeout
	show()
	if(Input.is_action_just_pressed("pause") && get_tree().is_paused() == true):
		get_tree().paused = false


func _on_exit_button_pressed():
	await get_tree().create_timer(0.1).timeout
	show()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	levelInfo.level = 1
	levelInfo.current_scene = null
	levelInfo.score = 0
	levelInfo.player_speed
	levelInfo.fire_rate = 0.8
	levelInfo.health = 2
	levelInfo.score_multiplier
	levelInfo.fire_rate_cost = 500
	levelInfo.health_cost = 1000
	levelInfo.score_mult_cost = 2000
	levelInfo.fire_rate_count = 0
	levelInfo.health_count = 0
	levelInfo.score_mult_count = 2000


func _on_resume_button_pressed():
	await get_tree().create_timer(0.1).timeout
	show()
	get_tree().paused = false
