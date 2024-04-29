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
	
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


# Switch cases and helper functions would work better here for scaling, but since there's
# only 3 upgrades with 3 levels, it's faster to just do it this way

# Score multiplier cost increases by 1000 every level
func _on_score_mult_up_pressed():
	if(current_score_mult_cost <= current_score && current_score_mult_count < 3):
		buy_sound()
		if(current_score_mult_count == 0):
			levelInfo.score_mult_count += 1
			levelInfo.score -= current_score_mult_cost
			levelInfo.score_mult_cost = 3000
			levelInfo.score_multiplier = 2
			$Labels/ScoreMultLabel.text = "score multiplier ii \n3000"
		elif(current_score_mult_count == 1):
			levelInfo.score_mult_count += 1
			levelInfo.score -= current_score_mult_cost
			levelInfo.score_mult_cost = 4000
			levelInfo.score_multiplier = 3
			$Labels/ScoreMultLabel.text = "score multiplier iii \n4000"
		else:
			levelInfo.score_mult_count += 1
			levelInfo.score -= current_score_mult_cost
			levelInfo.score_multiplier = 4
			$Labels/ScoreMultLabel.text = "MAX"
		current_score_mult_count = levelInfo.score_mult_count
	elif(current_score_mult_count != 3):
		$Labels/ScoreMultLabel/AnimationPlayer.play("NotEnough")
		not_enough_sound()
	current_score_mult_cost = levelInfo.score_mult_cost
	current_score = levelInfo.score
	$Labels/ScoreCounter.text = str(current_score)

# Health cost increases by 750 every level
func _on_health_up_pressed():
	if(current_health_cost <= current_score && current_health_count < 3):
		buy_sound()
		if(current_health_count == 0):
			levelInfo.health_count += 1
			levelInfo.score -= current_health_cost
			levelInfo.health_cost = 1750
			levelInfo.health = 3
			$Labels/HealthLabel.text = "health ii \n1750"
		elif(current_health_count == 1):
			levelInfo.health_count += 1
			levelInfo.score -= current_health_cost
			levelInfo.health_cost = 2500
			levelInfo.health = 4
			$Labels/HealthLabel.text = "health iii \n2500"
		else:
			levelInfo.health_count += 1
			levelInfo.score -= current_health_cost
			levelInfo.health = 5
			$Labels/HealthLabel.text = "MAX"
		current_health_count = levelInfo.health_count
	elif(current_health_count != 3):
		$Labels/HealthLabel/AnimationPlayer.play("NotEnough")
		not_enough_sound()
	current_health_cost = levelInfo.health_cost
	current_score = levelInfo.score
	$Labels/ScoreCounter.text = str(current_score)

# Fire rate cost increases by 500 every level
func _on_fire_rate_up_pressed():
	if(current_fire_rate_cost <= current_score && current_fire_rate_count < 3):
		buy_sound()
		if(current_fire_rate_count == 0):
			levelInfo.fire_rate_count += 1
			levelInfo.score -= current_fire_rate_cost
			levelInfo.fire_rate_cost = 1000
			levelInfo.fire_rate = 0.6
			$Labels/FireRateLabel.text = "fire rate ii \n1000"
		elif(current_fire_rate_count == 1):
			levelInfo.fire_rate_count += 1
			levelInfo.score -= current_fire_rate_cost
			levelInfo.fire_rate_cost = 1500
			levelInfo.fire_rate = 0.4
			$Labels/FireRateLabel.text = "fire rate iii \n1500"
		else:
			levelInfo.fire_rate_count += 1
			levelInfo.score -= current_fire_rate_cost
			levelInfo.fire_rate = 0.25
			$Labels/FireRateLabel.text = "MAX"
		current_fire_rate_count = levelInfo.fire_rate_count
	elif(current_fire_rate_count != 3):
		$Labels/FireRateLabel/AnimationPlayer.play("NotEnough")
		not_enough_sound()
	current_fire_rate_cost = levelInfo.fire_rate_cost
	current_score = levelInfo.score
	$Labels/ScoreCounter.text = str(current_score)

# These just make playing sounds easier
func buy_sound():
	$AudioStreamPlayer2D2.play()
	
func not_enough_sound():
	$AudioStreamPlayer2D3.play()
