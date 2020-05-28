extends Actor

signal collision(id)

func _physics_process(_delta: float) -> void:
	var direction: = Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	velocity = speed * direction.clamped(1)
	velocity = move_and_slide(velocity)

	if get_slide_count() >= 1:
#		is colliding
		var collision: = get_slide_collision(0)
		emit_signal("collision", collision.collider.get_instance_id())
	else:
		emit_signal("collision", 0)
	return
	

