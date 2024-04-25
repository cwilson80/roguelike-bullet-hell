extends Area2D

var start_pos = Vector2.ZERO
var speed = 80
var viewport_size = Vector2(720, 960)

#load bullet scene
var bullet_scene = preload("uid://qoddbhglyuap")

#Used to signal when an enemy is killed
signal died

#Spawning was only happening in center of screen, adjust as needed
var spawn_offset = 100  

func _ready():
	#Spawn the enemy initially
	start(Vector2(viewport_size.x / 2, -spawn_offset))

#Spawn enemy above view area and move at random intervals
func start(pos):
	position = Vector2(pos.x, pos.y)
	start_pos = pos
	$ShootCD.wait_time = 1
	$ShootCD.start()

#Allows movement
func _process(delta):
	# Check if the enemy is above the halfway point vertically
	if position.y < viewport_size.y / 12:
		position.y += speed * delta

	# Check if the enemy is below the halfway point vertically
	elif position.y > viewport_size.y / 12:
		speed = 0


func _on_shoot_cd_timeout():
	var bullet = bullet_scene.instantiate()
	bullet.speed = 600
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, 15), Vector2(0, 1))
	
	var secondary_bullet = bullet_scene.instantiate()
	secondary_bullet.speed = 500
	get_tree().root.add_child(secondary_bullet)
	secondary_bullet.start(position + Vector2(0, 15), Vector2(0, 1))
	
	$ShootCD.wait_time = 4
	$ShootCD.start()


func explode():
	speed = 0
	#need to add a death animation
	set_deferred("monitoring", false)
	died.emit(5)
	queue_free()
