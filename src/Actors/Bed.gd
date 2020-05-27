extends Area2D

export var health = 100.0

func _process(delta: float) -> void:
	health -= delta * 10
	if health < 0: 
		queue_free()

func _on_Bed_area_shape_entered(area_id: int, area: Area2D, area_shape: int, self_shape: int) -> void:
	health = 100.0
