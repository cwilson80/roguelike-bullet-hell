extends Node2D

#Loads enemies to use
var enemy = preload("res://scenes/enemy_rusher.tscn")
var enemyMid = preload("res://scenes/enemy_mid_range.tscn")
var enemyLong = preload("res://scenes/enemy_long_range.tscn")
var current_level = 1
var score = 0

func _ready():
	start()

#sets the current level and increments for the next level
func start():
	current_level = levelInfo.level
	levelInfo.level += 1
	spawn_enemies()

func spawn_enemies():
	spawn_rusher()
	spawn_long()
	spawn_mid()

#function for spawning rusher enemies
#spawns in 3 rows ^ of the current level of 4^current level of long range units
func spawn_rusher():
	for x in range(pow(4, current_level)):
		for y in range(pow(3, current_level)):
			var e = enemy.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)


#function for spawning mid range enemies
#spawns in 2 rows ^ of the current level of 3^current level of long range units
func spawn_mid():
	for x in range(pow(3, current_level)):
		for y in range(pow(2, current_level)):
			var em = enemyMid.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(em)
			em.start(pos)
			em.died.connect(_on_enemy_died)

#function for spawning long range enemies
#spawns in 2 rows ^ of the current level of 2^current level of long range units
func spawn_long():
	for x in range(pow(2, current_level)):
		for y in range(pow(2, current_level)):
			var em = enemyLong.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(em)
			em.start(pos)
			em.died.connect(_on_enemy_died)

func _on_enemy_died(value):
	score += value

func _process(delta):
	pass
