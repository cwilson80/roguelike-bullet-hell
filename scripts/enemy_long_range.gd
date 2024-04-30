extends Area2D


var start_pos = Vector2.ZERO
var speed = 80
var viewport_size = Vector2(720, 960)
var dead = false
var can_shoot = true

#load bullet scene
var bullet_scene = preload("uid://qoddbhglyuap")


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
	position = Vector2(pos.x, pos.y)
	start_pos = pos
	speed = 0
	$MoveTimer.wait_time = randf_range(8, 16)
	$MoveTimer.start()
	$ShootCD.wait_time = 16
	$ShootCD.start()


#Allows movement
func _process(delta):
	position.y += speed * delta
	
	if position.y > viewport_size.y / 12:
		speed = 40
	if position.y > viewport_size.y / 10:
		speed = 32
	if position.y > viewport_size.y / 8:
		speed = 16
	
	if position.y > viewport_size.y + 32:
		speed = 72
		start(Vector2(start_pos.x, -spawn_offset))


func _on_shoot_cd_timeout():
	if(can_shoot):
		var bullet = bullet_scene.instantiate()
		bullet.speed = 600
		get_tree().root.add_child(bullet)
		bullet.start(position + Vector2(0, 15), Vector2(0, 1))
		
		var secondary_bullet = bullet_scene.instantiate()
		secondary_bullet.speed = 500
		get_tree().root.add_child(secondary_bullet)
		secondary_bullet.start(position + Vector2(0, 15), Vector2(0, 1))
		
		$ShootCD.wait_time = randf_range(3, 5)
		$ShootCD.start()


func explode():
	can_shoot = false
	$HitDetection/CollisionShape2D.set_deferred("disabled", true)
	dead = true
	speed = 0
	$AnimatedSprite2D.play("death")
	$AudioStreamPlayer2D.play()
	set_deferred("monitoring", false)
	died.emit(15)
	dead = true
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_hit_detection_body_entered(body):
	if body.name == "Player":
		body.hit()
	else:
		explode()
		queue_free()


func _on_move_timer_timeout():
	speed = 80
