extends Node2D

var current_score
var current_fire_rate_cost
var current_health_cost
var current_score_mult_cost
var current_fire_rate_count
var current_health_count
var current_score_mult_count

# Called when the node enters the scene tree for the first time.
func _ready():
	current_score = levelInfo.score
	current_fire_rate_cost = levelInfo.fire_rate_cost
	current_health_cost = levelInfo.health_cost
	current_score_mult_cost = levelInfo.score_mult_cost
	current_fire_rate_count = levelInfo.fire_rate_count
	current_health_count = levelInfo.health_count
	current_score_mult_count = levelInfo.score_mult_count

	$Labels/ShopTitle1/AnimationPlayer.play("TextCreateSub")
	$Labels/ShopTitle2/AnimationPlayer.play("TextCreateMain")
	$BackgroundShop/AnimationPlayer.play("BackgroundSlide")
	$Labels/ScoreCounter.text = str(current_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

#TODO - Finish the other upgrade functions similar to the fire rate one, kinda ugly but it works

func _on_score_mult_up_pressed():
	pass # Replace with function body.


func _on_health_up_pressed():
	pass # Replace with function body.


func _on_fire_rate_up_pressed():
	if(current_fire_rate_cost >= current_score):
		if(current_fire_rate_count == 0):
			levelInfo.fire_rate_count += 1
			levelInfo.score -= current_fire_rate_cost
			levelInfo.fire_rate_cost = 1000
		elif(current_fire_rate_count == 1):
			levelInfo.fire_rate_count += 1
			levelInfo.score -= current_fire_rate_cost
			levelInfo.fire_rate_cost = 1500
		elif(current_fire_rate_count == 2):
			levelInfo.fire_rate_count += 1
			levelInfo.score -= current_fire_rate_cost
			levelInfo.fire_rate_cost = 2000
