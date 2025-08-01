class_name Enemy extends Area2D

@export var speed:int = 300

func _physics_process(delta: float) -> void:
	global_position.x += -speed * delta

func die() -> void:
	queue_free()
