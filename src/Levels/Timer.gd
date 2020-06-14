extends Timer

signal healBed(nr)

var atBed: = false
var bedObj: = 0

export var healTime = 2

func _ready() -> void:
	connect("timeout",self,"_on_timer_timeout") 

func _on_Player_collision(id, _station) -> void:	
	atBed = id > 0 
	if atBed:
		bedObj = id
	if is_stopped() :
		start(healTime)
	elif not atBed:
		stop()
	
func _on_timer_timeout():
	if atBed:
		emit_signal("healBed", bedObj)
