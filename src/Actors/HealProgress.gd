extends TextureProgress

var colliding: = false

func _ready() -> void:
	value = 0

func _on_Player_collision(id, _station) -> void:
	colliding = id > 0
	var tween = get_parent().get_node("Tween")
	if colliding and not tween.is_active():
		tween.interpolate_property(self, "value",0,100, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	elif not colliding:
		tween.reset_all()
