extends CharacterBody2D

@onready var screensize = get_viewport_rect().size

# Stats
@export var health = levelInfo.health
@export var move_speed = 450
@export var dash_speed = 1300
@export var slow_speed = 200
@export var bullet_speed = -1000
@export var consumable_move_speed = 100
@export var consumable_shoot_speed = 0.2

# Timer lengths
@export var dash_cooldown = 0.5
@export var dash_length = 0.15
@export var shoot_cooldown = levelInfo.fire_rate
@export var consumable_time = 3

@export var projectile : PackedScene

# States
var can_shoot = true
var can_dash = true
var dashing = false
var slow = false
var consumable_active = false
var invulnerable = false
var dead = false

func _process(_delta):
	# Get input direction
	var direction = Input.get_vector("left", "right", "up", "down")
	
	
	# Can only dash, slow, or move at a time
	if Input.is_action_just_pressed("dash") and can_dash and not slow: # Dash movement
		if(direction):
			$AudioStreamPlayer2D2.play()
			dashing = true
			can_dash = false
			$Timers/DashTimer.wait_time = dash_length
			$Timers/DashTimer.start()
			$Timers/DashCooldown.wait_time = dash_cooldown
			$Timers/DashCooldown.start()
			velocity = direction * dash_speed
	
	elif Input.is_action_just_pressed("slow") and not dashing: # Start slow movement
		slow = true
		$HitDetection/CollisionShape2D/ColorRect.visible = true
		$AnimatedSprite2D.modulate = Color(0.3, 0.3, 0.3, 1)
		shoot_cooldown = 0.15
	
	elif Input.is_action_pressed("slow") and slow: # Slow movement
		velocity = direction * slow_speed
	
	elif Input.is_action_just_released("slow") and slow: # End slow movement
		slow = false
		$HitDetection/CollisionShape2D/ColorRect.visible = false
		$AnimatedSprite2D.modulate = Color(1, 1, 1, 1)
		shoot_cooldown = 0.25
	
	elif not dashing and not slow: # Normal movement
		if consumable_active: # Consumable check
			velocity = direction * (move_speed + consumable_move_speed)
		else:
			velocity = direction * move_speed

	# Shoot check
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		$AudioStreamPlayer2D.play()
	
	if !dead:
		move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_cooldown = levelInfo.fire_rate


func shoot():
	can_shoot = false
	if consumable_active: # Apply consumable bonus
		$Timers/ShootCooldown.wait_time = clampf(shoot_cooldown - consumable_shoot_speed, 0.001, 9999)
	else:
		$Timers/ShootCooldown.wait_time = shoot_cooldown
	$Timers/ShootCooldown.start()
	var bullet = projectile.instantiate()
	bullet.speed = bullet_speed
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, -48))


func _on_gun_cooldown_timeout():
	can_shoot = true


func _on_dash_timer_timeout():
	dashing = false


func _on_dash_cooldown_timeout():
	can_dash = true


func hit():
	if !invulnerable:
		$AudioStreamPlayer2D4.play()
		invulnerable = true
		$Timers/InvulnerabilityTimer.start()
		health -= 1
		levelInfo.health = health
		get_node("../HUD/VBoxContainer/HealthText").text = "HP: " + str(health)
		if health <= 0:
			explode()
		hurt_flash()

func hurt_flash():
	get_node("../DamageOverlay").show()
	await get_tree().create_timer(0.1).timeout
	get_node("../DamageOverlay").hide()
	await get_tree().create_timer(0.1).timeout
	get_node("../DamageOverlay").show()
	await get_tree().create_timer(0.1).timeout
	get_node("../DamageOverlay").hide()

func restart():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func explode():
	$Timers/InvulnerabilityTimer.start(5)
	dead = true
	can_shoot = false
	dashing = true
	slow = false
	can_dash = false
	$AnimatedSprite2D.play("death")
	$AudioStreamPlayer2D3.play()
	#set_deferred("monitoring", false)
	await $AnimatedSprite2D.animation_finished
	reset_enemies()
	await reset_enemies()
	call_deferred("restart")

func reset_enemies():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()


func _on_consumable_detection_body_entered(body):
	body.queue_free()
	$Timers/ConsumableTimer.wait_time = consumable_time
	$Timers/ConsumableTimer.start()
	consumable_active = true


func _on_consumable_timer_timeout():
	consumable_active = false


func _on_invulnerability_timer_timeout():
	invulnerable = false
