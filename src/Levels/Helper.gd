extends Actor

onready var timer: Timer = $Timer
var target:Patient = null
var targetPos:Vector2
var running: = true
var replan: = false
var ignore: = 0

func _ready() -> void:
	speed = 170 
	timer.connect("timeout", self, "_set_running")
	visible = false

func _physics_process(delta: float) -> void:
	if target == null: 
		timer.start(2)
		target = _find_next_target()
		targetPos = target.global_position
		replan = false
		ignore = 0
		return
	
	if not running:
		return
		
	velocity = global_position.direction_to(targetPos) * speed
	velocity = move_and_slide(velocity)
	
	if get_slide_count() >= 1:
		var collision: = get_slide_collision(0)
		if collision.collider == target:
			_goal_reached(true)
	elif targetPos.distance_to(global_position) <= 30:
		_goal_reached(true)

func _set_running():
	running = true
	
func _goal_reached(heal):
	if heal:
		target.heal()
	running = replan
	target = null

func _find_next_target() -> Patient:
	var lowest: = 101
	var targetNode:Patient = null
	for item in get_parent().get_children():
		if item.is_in_group('Anest'):
			if targetNode == null:
				targetNode = item
			if ignore == item.get_instance_id():
				break
			if item.health < lowest:
				lowest = targetNode.health
				targetNode = item
	return targetNode

func _on_GlobalState_gameModeChanged(_level) -> void:
	visible = true


func _on_Player_collision(id, _isStation) -> void:
	if target and target.get_instance_id() == id:
		ignore = id
		replan = true
		_goal_reached(false)
