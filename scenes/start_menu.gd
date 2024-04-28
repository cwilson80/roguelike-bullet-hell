extends Node2D

@onready var anim_player = $BackgroundStart/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTitle/AnimationPlayer.play("TextCreateTitle")
	$Buttons/StartButton/AnimationPlayer.play("TextCreateStart")
	$Buttons/AboutButton/AnimationPlayer.play("TextCreateAbout")
	$Buttons/QuitButton/AnimationPlayer.play("TextCreateQuit")
	
	$Buttons/BackButton.hide()
	$AboutInfo.hide()
	anim_player.play("Slide")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_about_button_pressed():
	$Buttons/StartButton.hide()
	$Buttons/AboutButton.hide()
	$Buttons/QuitButton.hide()
	
	$Buttons/BackButton.show()
	$AboutInfo.show()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_back_button_pressed():
	$Buttons/BackButton.hide()
	$AboutInfo.hide()
	
	$Buttons/StartButton.show()
	$Buttons/AboutButton.show()
	$Buttons/QuitButton.show()

# Idle animation for the title text
func _on_animation_player_animation_finished(TextCreateTitle):
	$GameTitle/AnimationPlayer.play("TitleIdle")
