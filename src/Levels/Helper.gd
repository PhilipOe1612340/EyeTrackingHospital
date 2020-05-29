extends Actor

signal helped(idx)

#onready var nav: Navigation2D = get_parent().get_node("Navigation2D")
onready var timer: Timer = $Timer
var target:Bed = null
var targetPos:Vector2
var running: = true

func _ready() -> void:
	speed = 200 
	timer.connect("timeout", self, "_set_running")
	get_parent().get_node("Line2D").add_point(global_position)
	
func _physics_process(delta: float) -> void:
	if target == null: 
		timer.start(2)
		running = false
		target = _find_next_target()
		targetPos = target.global_position
		return
	
	velocity = global_position.direction_to(targetPos) * speed
	velocity = move_and_slide(velocity)
	
	if get_slide_count() >= 1:
		var collision: = get_slide_collision(0)
		if collision.collider == target:
			_goal_reached()
	elif targetPos.distance_to(global_position) <= 30:
		_goal_reached()

func _set_running():
	running = true
	get_parent().get_node("Line2D").add_point(targetPos)
	
func _goal_reached():
	emit_signal("helped", target.get_instance_id())
	running = false
	target = null

func _find_next_target() -> Bed:
	var lowest: = 101
	var targetNode:Bed = null
	for item in get_parent().get_children():
		if item.is_in_group('Anest'):
			if targetNode == null:
				targetNode = item
			if item.health < lowest:
				lowest = targetNode.health
				targetNode = item
	return targetNode

