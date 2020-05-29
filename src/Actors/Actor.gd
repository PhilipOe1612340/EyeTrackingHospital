extends KinematicBody2D

class_name Actor

export var speed: = 300
var velocity: = Vector2.ZERO

func _physics_process(_delta) -> void:
	velocity = velocity.normalized() * speed
	
	
	
