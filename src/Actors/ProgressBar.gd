extends ProgressBar


func _process(_delta: float) -> void:
	var health = get_parent().health
	value = stepify(health, 0.1)
	var green = Color(0.0, 1.0, 0.0)
	var red = Color(1.0, 0.0, 0.0)
	self['custom_styles/fg'].bg_color = red.linear_interpolate(green, value / 100)
	return
