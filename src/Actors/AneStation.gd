extends Patient

func _ready() -> void:
	self.stepTime = 1
	self.stepSize = 0.1

func _on_GlobalState_gameModeChanged(level) -> void:
	if level == 1 or level == 3:
		self.stepSize = 0.8
		self.stepTime = 0.3
	if level == 2:
		self.stepTime = 0.11
		self.stepSize = 1.05
	return

func heal():
	self._on_healBed(0, true)
