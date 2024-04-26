extends StaticBody2D


var alternate

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_timeout():
	if alternate:
		modulate = Color(1, 1, 1, 0.2)
		alternate = false
	else:
		modulate = Color(1, 1, 1, 1)
		alternate = true
	
	$AnimationTimer.start()
