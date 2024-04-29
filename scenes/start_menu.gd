extends Node2D

@onready var anim_player = $BackgroundStart/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTitle/AnimationPlayer.play("TextCreateTitle")
	$Buttons/StartButton/AnimationPlayer.play("TextCreateStart")
	$Buttons/AboutButton/AnimationPlayer.play("TextCreateAbout")
	$Buttons/HowButton/AnimationPlayer.play("TextCreateHow")
	$Buttons/QuitButton/AnimationPlayer.play("TextCreateQuit")
	$ColorRect/AnimationPlayer.play("Flash")
	
	$Buttons/BackButton.hide()
	$HowToPlay.hide()
	$AboutInfo.hide()
	
	# I don't know what anim_player is, but this works I think so don't mess with it
	anim_player.play("Slide")
	
	$AudioStreamPlayer2D2.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_about_button_pressed():
	$Buttons/StartButton.hide()
	$Buttons/AboutButton.hide()
	$Buttons/QuitButton.hide()
	$Buttons/HowButton.hide()
	
	$Buttons/BackButton.show()
	$AboutInfo.show()
	
	$AudioStreamPlayer2D.play()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_back_button_pressed():
	$Buttons/BackButton.hide()
	$AboutInfo.hide()
	$HowToPlay.hide()
	
	$Buttons/StartButton.show()
	$Buttons/AboutButton.show()
	$Buttons/QuitButton.show()
	$Buttons/HowButton.show()
	
	$AudioStreamPlayer2D.play()

# Idle animation for the title text
func _on_animation_player_animation_finished(TextCreateTitle):
	$GameTitle/AnimationPlayer.play("TitleIdle")


func _on_how_button_pressed():
	$Buttons/StartButton.hide()
	$Buttons/AboutButton.hide()
	$Buttons/QuitButton.hide()
	$Buttons/HowButton.hide()
	
	$Buttons/BackButton.show()
	$HowToPlay.show()
	
	$AudioStreamPlayer2D.play()
