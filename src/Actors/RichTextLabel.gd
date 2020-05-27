extends RichTextLabel

func _process(delta: float) -> void:
	var health:float = get_parent().health
	set_text(str(stepify(health, 0.1)))
	return

