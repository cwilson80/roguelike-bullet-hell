extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShopTitle1/AnimationPlayer.play("TextCreateSub")
	$ShopTitle2/AnimationPlayer.play("TextCreateMain")
	$BackgroundShop/AnimationPlayer.play("BackgroundSlide")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
