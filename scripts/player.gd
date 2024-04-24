extends CharacterBody2D

@onready var screensize = get_viewport_rect().size
@export var speed = 350
@export var cooldown = 0.25
@export var bullet_scene : PackedScene
var can_shoot = true

func _process(delta):
	var input = Input.get_vector("left", "right", "up", "down")
	position += input * speed * delta
	position = position.clamp(Vector2.ZERO, screensize)
	if Input.is_action_just_pressed("shoot"):
		shoot()


# Called when the node enters the scene tree for the first time.
func _ready():
	start()


func start():
	position = Vector2(screensize.x/2, screensize.y - 64)
	$GunCooldown.wait_time = cooldown


func shoot():
	#check if player is able to shoot
	if not can_shoot:
		return
	#if player can shoot, start cooldown and spawn projectile called bullet
	can_shoot = false
	$GunCooldown.start()
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, -48))


func _on_gun_cooldown_timeout():
	can_shoot = true
