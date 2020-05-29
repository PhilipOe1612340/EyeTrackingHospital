extends Bed

func _ready() -> void:
	stepTime = 1
	stepSize = 0.1

func _on_GlobalState_gameModeChanged(level) -> void:
	print(level)
	if level == 1:
		stepSize = 1.2
		stepTime = 0.4
	if level == 2:
		stepTime = 0.1

func _on_Helper_helped(idx) -> void:
	_on_healBed(idx)
