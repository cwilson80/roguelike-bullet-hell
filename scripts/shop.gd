extends Node2D

var current_score = levelInfo.score
var shop_contents = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$Labels/ShopTitle1/AnimationPlayer.play("TextCreateSub")
	$Labels/ShopTitle2/AnimationPlayer.play("TextCreateMain")
	$BackgroundShop/AnimationPlayer.play("BackgroundSlide")

# This decides what is available in the shop when it's visited
func shop_content_picker():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
