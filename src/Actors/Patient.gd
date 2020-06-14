extends StaticBody2D
class_name Patient

signal accident()

export var health = 100.0
export var stepSize = 2
export var stepTime: = 0.2

var rng = RandomNumberGenerator.new()
var timer
var tween

func _ready() -> void:
	rng.randomize()
	var playerHealTimer: = get_parent().get_node("Timer")
	playerHealTimer.connect('healBed', self, '_on_healBed')
	
	timer = $HealthTimer
	tween = $Tween
	
	timer.connect('timeout', self, '_randomStep')
	_randomStep()

func _randomStep():
	var healthChange = rng.randf_range(-2 * stepSize, stepSize)
	
	tween.interpolate_property(self, "health",health,health+healthChange, stepTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	if health < 0: 
		emit_signal("accident")
		tween.stop_all()
		health = 100
	
	timer.start(stepTime)
	return

func _on_healBed(id, skip = false) -> void:
	if get_instance_id() == id or skip:
			tween.stop_all()
			health = 100


func _on_GlobalState_gameModeChanged(level) -> void:
	print('not allowed', level)
	pass # Replace with function body.
