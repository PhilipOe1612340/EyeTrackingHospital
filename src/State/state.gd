extends Node

signal scoreChanged(score)
signal gameModeChanged(level)
signal done()

const debugCursor: = false
var score: = 0
var loggingEnabled: = false
var playSound: = false

export var startSecondLevelAfter:int = 4
export var startThirdLevelAfter:int = startSecondLevelAfter + 8
var counter: = 0
var lastCollIdx: = 0
var mousePos: = ""
var mode = 0

var start = 0
var gameDuration = 1 * 60 * 1000
var playerPos: = Vector2(0, 0)

var cam:Camera2D

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
	if playSound:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		get_children()[rng.randi() % 2].play()

func _on_Player_collision(idx, isStation) -> void:
	var collision = idx > 0
	loggingEnabled = true || collision
	if collision and lastCollIdx != idx:
		counter += 1
	else:
		return
	
	if startSecondLevelAfter == counter:
		mode = 1
		emit_signal("gameModeChanged", mode)
		save(mousePos)
	if startThirdLevelAfter == counter:
		mode = 2
		emit_signal("gameModeChanged", mode)
	if startThirdLevelAfter < counter and isStation and not mode == 3:
		mode = 3
		emit_signal("gameModeChanged", mode)
		start = OS.get_ticks_msec()
		
	lastCollIdx = idx
	return
	
func getCam() -> Camera2D:
	if cam:
		return cam
	var node = get_parent()
	var player = node.get_node("Player")
	if not player:
		return null;
	var camera = player.get_node("Camera2D")
	if camera:
		cam = camera
	return camera

var title = "Game v0."
func _process(_delta):
	OS.set_window_title(title + str(mode) + " | fps: " + str(Engine.get_frames_per_second()))

	if loggingEnabled:
		var pos = get_viewport().get_mouse_position()
		var cam = getCam()
		if cam:
			pos += cam.get_camera_position() - get_viewport().get_visible_rect().size / 2
			
		mousePos += str([OS.get_ticks_msec(), pos.x, pos.y, playerPos.x, playerPos.y, mode]).replace('[', '').replace(']', '') + "\n"
		if debugCursor:
			print(mousePos)	
	if (OS.get_ticks_msec() - start) > gameDuration and mode == 3:
		emit_signal("done")
		save(mousePos)

func save(content):
	var file = File.new()
	file.open("./pos.csv", File.WRITE)
	file.store_string(content)
	file.close()
	
func _on_GlobalState_done() -> void:
	pass # Replace with function body.


func _on_Player_move(pos) -> void:
	if pos.length() > 1:
		playerPos = pos
