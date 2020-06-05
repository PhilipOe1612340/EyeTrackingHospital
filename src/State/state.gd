extends Node

signal scoreChanged(score)
signal gameModeChanged(level)

const debugCursor: = true
var score: = 0
var loggingEnabled: = false
var playSound: = false

export var startSecondLevelAfter: = 4
export var startThirdLevelAfter: = 8
var counter: = 0
var lastCollIdx: = 0

func _ready() -> void:
	if not debugCursor:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#	connect all patients to score
	for item in get_parent().get_children():
		if item.is_in_group('Patients'):
			print(item.get_groups())
			item.connect('accident', self, '_onAccident')
	
func _onAccident():
	score += 1
	emit_signal("scoreChanged", score)
	if playSound:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		get_children()[rng.randi() % 2].play()

func _input(event):
   # Mouse in viewport coordinates
   if event is InputEventMouseMotion and loggingEnabled:
	   print(event.global_position.x,',' ,event.global_position.y)
	

func _on_Player_collision(idx) -> void:
	var collision = idx > 0
	loggingEnabled = collision
	if collision and lastCollIdx != idx:
		counter += 1
	else:
		return
	
	if startSecondLevelAfter == counter:
		emit_signal("gameModeChanged", 1)
		print(1)
	if startThirdLevelAfter == counter:
		emit_signal("gameModeChanged", 2)
		print(2)
		
	lastCollIdx = idx
	return

var title = "Game v0.1"
func _process(_delta):
	OS.set_window_title(title + " | fps: " + str(Engine.get_frames_per_second()))
