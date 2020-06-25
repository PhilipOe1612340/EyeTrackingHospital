extends Actor

signal collision(id, isStation)
signal move(pos)

func _physics_process(_delta: float) -> void:
	var direction: = Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	velocity = speed * direction.clamped(1)
	velocity = move_and_slide(velocity)

	if get_slide_count() >= 1:
#		is colliding
		var collision: = get_slide_collision(0)
		var coll:Node = collision.collider
		emit_signal("collision", coll.get_instance_id(), coll.is_in_group('Anest'))
	else:
		emit_signal("collision", 0, false)
		emit_signal("move", global_position)
	
	return
	

