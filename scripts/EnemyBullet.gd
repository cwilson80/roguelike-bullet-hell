extends Area2D

@export var speed = 100
var direction = Vector2(0, -1).normalized()  # Default direction (vertical)


func start(pos, direction):
	position = pos
	self.direction = direction.normalized()


func _process(delta):
	position += speed * delta * direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


#if bullet hits player, remove player
func _on_area_entered(area):
	if area.name == "Player":
		queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		body.hit()
