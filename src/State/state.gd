extends Node

signal scoreChanged(score)

const debugCursor: = true
var score: = 0
var loggingEnabled: = false

func _ready() -> void:
	if not debugCursor:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#	connect all patients to score
	for item in get_parent().get_children():
		if item.is_in_group('Patients'):
			item.connect('accident', self, '_onAccident')
	
func _onAccident():
	score += 1
	emit_signal("scoreChanged", score)

func _input(event):
   # Mouse in viewport coordinates
   if event is InputEventMouseMotion and loggingEnabled:
	   print(event.position.x,',' ,event.position.y)
	

func _on_Player_collision(enabled) -> void:
	loggingEnabled = false
	loggingEnabled = enabled > 0
	return


var title = "Game v0.1"

func _process(_delta):
	OS.set_window_title(title + " | fps: " + str(Engine.get_frames_per_second()))
