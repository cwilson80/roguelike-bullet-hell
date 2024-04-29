extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	$FinalScore.text = "Final Score: " + str(levelInfo.score)
	$FinalLevel.text = "You made it to level " + str(levelInfo.level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	# Soooooo this is kinda ugly code, would wanna make a function to do this, but
	# Since this is only required like three times, it's not that useful to take
	# the time to make a function for it and I'm lazy
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


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu")
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
