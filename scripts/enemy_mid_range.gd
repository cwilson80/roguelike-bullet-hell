extends Area2D


var start_pos = Vector2.ZERO
var speed = 100
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
	$AnimatedSprite2D.play("defualt")


#Spawn enemy above view area and move at random intervals
func start(pos):
	position = Vector2(pos.x, pos.y)
	start_pos = pos
	$ShootCD.wait_time = 4
	$ShootCD.start()


#Allows movement
func _process(delta):
	position.y += speed * delta
	
	if position.y > viewport_size.y / 2:
		speed = 20
	
	if position.y > viewport_size.y + 32:
		speed = 90
		start(Vector2(start_pos.x, -spawn_offset))


func _on_shoot_cd_timeout():
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, 15), Vector2(0, 1))
	
	var angle_degrees = 80
	var angle_radians = deg_to_rad(angle_degrees)
	var right_side_bullet = bullet_scene.instantiate()
	get_tree().root.add_child(right_side_bullet)
	right_side_bullet.start(position + Vector2(0, 15), Vector2(cos(angle_radians), sin(angle_radians)).normalized())	
	
	var angle_degrees_left = 100
	var angle_radians_left = deg_to_rad(angle_degrees_left)
	var left_side_bullet = bullet_scene.instantiate()
	get_tree().root.add_child(left_side_bullet)
	left_side_bullet.start(position + Vector2(0, 15), Vector2(cos(angle_radians_left), sin(angle_radians_left)).normalized())


	$ShootCD.wait_time = 4
	$ShootCD.start()


func explode():
	speed = 0
	$AnimatedSprite2D.play("death")
	set_deferred("monitoring", false)
	died.emit(5)
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_hit_detection_body_entered(body):
	explode()
	queue_free()
