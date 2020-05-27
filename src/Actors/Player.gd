extends Actor

func _physics_process(delta: float) -> void:
	var direction: = Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	velocity = speed * direction.clamped(1);
	velocity = move_and_slide(velocity)
	return
	
