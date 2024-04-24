extends CharacterBody2D

@onready var screensize = get_viewport_rect().size

@export var health = 5
@export var move_speed = 450
@export var dash_speed = 1300
@export var bullet_speed = -1000

@export var bullet_scene : PackedScene
@export var shoot_cooldown = 0.25
@export var dash_length = 0.15
@export var dash_cooldown = 0.5

var can_shoot = true
var can_dash = true
var dashing = false

func _process(delta):
	#Get inputted direction
	var direction = Input.get_vector("left", "right", "up", "down")
	
	#Only allow movement when not dashing
	if not dashing:
		velocity = direction * move_speed
	
	#Handle dashing
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$Timers/DashTimer.wait_time = dash_length
		$Timers/DashTimer.start()
		$Timers/DashCooldown.wait_time = dash_cooldown
		$Timers/DashCooldown.start()
		velocity = direction * dash_speed
	
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
	
	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func shoot():
	#if player can shoot, start cooldown and spawn projectile called bullet
	can_shoot = false
	$Timers/ShootCooldown.wait_time = shoot_cooldown
	$Timers/ShootCooldown.start()
	
	var bullet = bullet_scene.instantiate()
	bullet.speed = bullet_speed
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, -48))


func _on_gun_cooldown_timeout():
	can_shoot = true


func _on_dash_timer_timeout():
	dashing = false


func _on_dash_cooldown_timeout():
	can_dash = true


func _on_hit_detection_body_entered(_body):
	health -= 1
	print("Hit!")
