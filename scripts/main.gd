extends Node2D

#Loads enemies to use
var enemy = preload("res://scenes/enemy_rusher.tscn")
var enemyMid = preload("res://scenes/enemy_mid_range.tscn")
var enemyLong = preload("res://scenes/enemy_long_range.tscn")
var current_level = 0
var current_score = 0
var current_health = 2

func _ready():
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D3.play()
	start()

#sets the current level and increments for the next level
func start():
	current_level = levelInfo.level
	current_score = levelInfo.score
	current_health = levelInfo.health
	
	$HUD/VBoxContainer/LevelText.text = "Level " + str(current_level)
	$HUD/VBoxContainer/ScoreText.text = "Score: " + str(current_score)
	$HUD/VBoxContainer/HealthText.text = "HP: " + str(current_health)
	$Background/AnimationPlayer.play("ParallaxOverTime")
	spawn_enemies()
	$LevelTimer.start()

func spawn_enemies():
	spawn_rusher()
	spawn_long()
	spawn_mid()

#function for spawning rusher enemies
func spawn_rusher():
	# Adjust these parameters as needed
	var base_spawn_rate = 4
	var initial_level_threshold = 10
	var steepness_factor = 0.5  # Adjust how steep the increase is after the threshold

	# Calculate the number of enemies to spawn based on the current level
	var enemies_to_spawn = calculate_enemies_to_spawn(base_spawn_rate, initial_level_threshold, steepness_factor)

	# Spawn enemies
	for x in range(enemies_to_spawn):
		for y in range(3):
			var e = enemy.instantiate()
			var random_x = randi() % (700) + 5  # Generate a random x within the specified range
			var pos = Vector2(random_x, -48 * 4 - 48 + y * 48)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)


#function for spawning mid range enemies
func spawn_mid():
	var base_spawn_rate = 2  # Adjust as needed
	var initial_level_threshold = 10
	var steepness_factor = 0.2  # Adjust as needed

	var enemies_to_spawn = calculate_enemies_to_spawn(base_spawn_rate, initial_level_threshold, steepness_factor)

	for x in range(enemies_to_spawn):
		for y in range(2):
			var em = enemyMid.instantiate()
			var random_x = randi() % (700) + 5
			var pos = Vector2(random_x, -48 * 4 - 48 + y * 48)
			add_child(em)
			em.start(pos)
			em.died.connect(_on_enemy_died)


#function for spawning long range enemies
func spawn_long():
	var base_spawn_rate = 2  # Adjust as needed
	var initial_level_threshold = 15
	var steepness_factor = 0.1  # Adjust as needed

	var enemies_to_spawn = calculate_enemies_to_spawn(base_spawn_rate, initial_level_threshold, steepness_factor)

	for x in range(enemies_to_spawn):
		for y in range(2):
			var el = enemyLong.instantiate()
			var random_x = randi() % (700) + 20
			var pos = Vector2(random_x, -48 * 4 - 48 + y * 48)
			add_child(el)
			el.start(pos)
			el.died.connect(_on_enemy_died)


# Function to calculate the number of enemies to spawn based on the current level
func calculate_enemies_to_spawn(base_spawn_rate, initial_level_threshold, steepness_factor):
	if current_level <= initial_level_threshold:
		# Slow increase for the initial levels
		return (base_spawn_rate * current_level) - current_level
	else:
		# Ramp up more aggressively after the threshold
		var adjusted_level = current_level - initial_level_threshold
		return base_spawn_rate * initial_level_threshold + (adjusted_level * steepness_factor)


func _on_enemy_died(value):
	levelInfo.score += value * levelInfo.score_multiplier
	current_score = levelInfo.score
	$HUD/VBoxContainer/ScoreText.text = "Score: " + str(current_score)
	

# Levels the player up every minute, though this is subject to change
# Right now, the player is taken to the shop every 3 levels
func _on_level_timer_timeout():
	next_level()

func reset_enemies():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()
		
# This handles the visibility of the "Level Up" text
# More specifically, it hides the text once the animation is done
func _on_animation_player_animation_finished(LevelUpFlash):
	$CanvasLayer/LevelUpText.hide()

func _process(delta):
	# This handles pausing the game
	$PauseMenu.hide()
	if(Input.is_action_just_pressed("pause") && get_tree().is_paused() == false):
		get_tree().paused = true
	if count_alive_enemies() == 0:
		next_level()

func count_alive_enemies():
	var enemy_count = 0
	var scene_tree = get_tree()

	# Iterate through all nodes in the scene tree
	for node in scene_tree.get_nodes_in_group("enemies"):
		# Check if the node is an enemy and it's not queued for deletion
		if node.is_in_group("enemies"):
			enemy_count += 1

	return enemy_count

func next_level():
	$AudioStreamPlayer2D4.play()
	$LevelTimer.start()
	levelInfo.level += 1
	current_level = levelInfo.level
	$HUD/VBoxContainer/LevelText.text = "Level " + str(current_level)
	$CanvasLayer/LevelUpText.text = "Level Up! \nLevel " + str(current_level)
	$CanvasLayer/LevelUpText.show()
	$CanvasLayer/LevelUpText/AnimationPlayer.play("LevelUpFlash")
	# This decides whether to go to the shop or not
	if current_level % 3 == 0:
		reset_enemies()
		await("reset_enemies")
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
	spawn_enemies()
