extends CharacterBody2D

var start_pos = Vector2.ZERO
var speed = 0
var viewport_size = Vector2(720, 960)

#Used to signal when an enemy is killed
signal died

#Spawning was only happening in center of screen, adjust as needed
var spawn_offset = 100  

func _ready():
	#Spawn the enemy initially
	start(Vector2(viewport_size.x / 2, -spawn_offset))

#Spawn enemy above view area and move at random intervals
func start(pos):
	speed = 0
	position = Vector2(pos.x, pos.y)
	start_pos = pos
	$MoveTimer.wait_time = randf_range(5, 20)
	$MoveTimer.start()

#Randomize speed
func _on_move_timer_timeout():
	speed = randf_range(75, 100)

#Allows movement
func _process(delta):
	position.y += speed * delta
	if position.y > viewport_size.y + 32:
		start(Vector2(start_pos.x, -spawn_offset))


func explode():
	speed = 0
	#need to add a death animation
	set_deferred("monitoring", false)
	died.emit(5)
	queue_free()


func _on_hit_detection_body_entered(body):
	queue_free()
