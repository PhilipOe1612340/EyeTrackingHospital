extends KinematicBody2D

class_name Actor

export var speed: = 300
var velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.x = max(velocity.x, speed);
	velocity.y = max(velocity.y, speed);
	
	
	
