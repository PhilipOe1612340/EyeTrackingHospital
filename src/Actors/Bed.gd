extends Patient


func _on_GlobalState_gameModeChanged(level) -> void:
	if level > 1:
		stepSize = 0.75
		stepTime = 0.2
