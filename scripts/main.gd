extends Node2D

#Loads enemies to use
var enemy = preload("res://scenes/enemy_rusher.tscn")
var enemyMid = preload("res://scenes/enemy_mid_range.tscn")
var current_level = 1
var score = 0

func _ready():
	start()

#testing function for spawning enemies
func spawning_enemies():
	for x in range(9):
		for y in range(3):
			var e = enemy.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)
			print("spawning")
	for x in range(3):
		for y in range(1):
			var em = enemyMid.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(em)
			em.start(pos)
			em.died.connect(_on_enemy_died)
			print("spawning")

#sets the current level and increments for the next level
func start():
	current_level = levelInfo.level
	spawn_enemies()

func spawn_enemies():
	for x in range(pow(4, current_level)):
		for y in range(pow(3, current_level)):
			var e = enemy.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)
	for x in range(pow(3, current_level)):
		for y in range(pow(1, current_level)):
			var em = enemyMid.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(em)
			em.start(pos)
			em.died.connect(_on_enemy_died)

func _on_enemy_died(value):
	score += value

func _process(delta):
	pass
