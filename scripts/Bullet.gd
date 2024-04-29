extends Area2D
@export var speed = -250


func start(pos):
	position = pos


func _process(delta):
	position.y += speed * delta


func _on_area_entered(area):
	if area.is_in_group("enemies") and area.dead == false:
		area.explode()
		queue_free() #removes the node safely to help save resources

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
