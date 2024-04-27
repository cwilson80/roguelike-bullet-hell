extends StaticBody2D

@export var speed = 200
var alternate

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta


func _on_animation_timeout():
	if alternate:
		modulate = Color(1, 1, 1, 0.2)
		alternate = false
	else:
		modulate = Color(1, 1, 1, 1)
		alternate = true


func _on_delete_timer_timeout():
	queue_free()
