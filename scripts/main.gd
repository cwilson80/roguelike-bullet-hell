extends Node2D

#Loads enemies to use
var enemy = preload("res://scenes/enemy_rusher.tscn")
var enemyMid = preload("res://scenes/enemy_mid_range.tscn")
var enemyLong = preload("res://scenes/enemy_long_range.tscn")
var current_level = 0
var current_score = 0

func _ready():
	start()

#sets the current level and increments for the next level
func start():
	current_level = levelInfo.level
	spawn_enemies()
	$LevelTimer.start()

func spawn_enemies():
	spawn_rusher()
	spawn_long()
	spawn_mid()

#function for spawning rusher enemies
#spawns in 3 rows ^ of the current level of 4^current level of long range units
func spawn_rusher():
	for x in range(pow(4, current_level)):
		for y in range(pow(3, snappedi(1, current_level*.1))):
			var e = enemy.instantiate()
			var random_x = randi() % (700) + 5  # Generate a random x within the specified range
			var pos = Vector2(random_x, -48 * 4 - 48 + y * 48)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)


#function for spawning mid range enemies
#spawns in 2 rows ^ of the current level of 3^current level of long range units
func spawn_mid():
	for x in range(pow(3, current_level)):
		for y in range(pow(2, snappedi(1, current_level*.1))):
			var em = enemyMid.instantiate()
			var random_x = randi() % (700) + 5  # Generate a random x within the specified range
			var pos = Vector2(random_x, -48 * 4 - 48 + y * 48)
			add_child(em)
			em.start(pos)
			em.died.connect(_on_enemy_died)


#function for spawning long range enemies
#spawns in 2 rows ^ number of the current level of 2^1-.1*current level of long range units
func spawn_long():
	for x in range(pow(2, current_level)):
		for y in range(pow(2, snappedi(1, current_level*.1))):
			var el = enemyLong.instantiate()
			var random_x = randi() % (700) + 20  # Generate a random x within the specified range
			var pos = Vector2(random_x, -48 * 4 - 48 + y * 48)
			add_child(el)
			el.start(pos)
			el.died.connect(_on_enemy_died)


func _on_enemy_died(value):
	levelInfo.score += value
	current_score = levelInfo.score
	$HUD/VBoxContainer/ScoreText.text = "Score: " + str(current_score)
	

# Levels the player up every minute, though this is subject to change
# Right now, the player is taken to the shop every 3 levels
func _on_level_timer_timeout():
	levelInfo.level += 1
	current_level = levelInfo.level
	$HUD/VBoxContainer/LevelText.text = "Level " + str(current_level)
	$CanvasLayer/LevelUpText.text = "Level Up! \nLevel " + str(current_level)
	$CanvasLayer/LevelUpText.show()
	$CanvasLayer/LevelUpText/AnimationPlayer.play("LevelUpFlash")
	# This decides whether to go to the shop or not
	if current_level % 3 == 0:
		#goto_scene("res://scenes/shop.tscn") # This scene does not exist yet
		get_tree().change_scene_to_file("res://scenes/shop.tscn")

# This handles the visibility of the "Level Up" text
# More specifically, it hides the text once the animation is done
func _on_animation_player_animation_finished(LevelUpFlash):
	$CanvasLayer/LevelUpText.hide()

func _process(delta):
	pass
