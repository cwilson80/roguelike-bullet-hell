extends Node2D

#Loads enemies to use
var enemy = preload("uid://dca31lgf1n6va")
var enemyMid = preload("uid://qa58ublw1g87")
var current_level = null
var score = 0

func _process(delta):
	pass

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
	for x in range(3):
		for y in range(1):
			var em = enemyMid.instantiate()
			var pos = Vector2(x * (48 + 24) + 72, -48 * 4 - 48 + y * 48)
			add_child(em)
			em.start(pos)
			em.died.connect(_on_enemy_died)

#sets the current level and increments for the next level
func start():
	current_level == $levelInfo.get_level()
	$levelInfo.next_level()

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
