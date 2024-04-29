extends Area2D

var start_pos = Vector2.ZERO
var speed = 0
var viewport_size = Vector2(720, 960)
var dead = false

#Used to signal when an enemy is killed
signal died

#Spawning was only happening in center of screen, adjust as needed
var spawn_offset = 100  

func _ready():
	#Spawn the enemy initially
	start(Vector2(viewport_size.x / 2, -spawn_offset))
	$AnimatedSprite2D.play("default")

#Spawn enemy above view area and move at random intervals
func start(pos):
	speed = 0
	position = Vector2(pos.x, pos.y)
	start_pos = pos
	$MoveTimer.wait_time = randf_range(0, 8)
	$MoveTimer.start()

#Randomize speed
func _on_move_timer_timeout():
	speed = randf_range(50, 115)

#Allows movement
func _process(delta):
	position.y += speed * delta
	if position.y > viewport_size.y + 32:
		start(Vector2(start_pos.x, -spawn_offset))


func explode():
	speed = 0
	$AnimatedSprite2D.play("death")
	$AudioStreamPlayer2D.play()
	set_deferred("monitoring", false)
	died.emit(5)
	dead = true
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_hit_detection_body_entered(body):
	if body.name == "Player":
		body.hit()
	else:
		explode()
		queue_free()
