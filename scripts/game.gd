extends Node2D

func _on_deathzone_area_entered(enemy: Enemy) -> void:
	enemy.die()
