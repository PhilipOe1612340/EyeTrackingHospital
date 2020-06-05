extends Bed

func _ready() -> void:
	self.stepTime = 1
	self.stepSize = 0.1

func _on_GlobalState_gameModeChanged(level) -> void:
	if level == 1:
		self.stepSize = 1.2
		self.stepTime = 0.4
	if level == 2:
		self.stepTime = 0.1
	return

func heal():
	self._on_healBed(0, true)
