extends Node2D

@onready var player = $Player
@onready var hud = $UI/HUD

var lives: int = 3
var score: int = 0

func _ready() -> void:
	hud.set_score_label(score)

func _on_deathzone_area_entered(enemy: Enemy) -> void:
	enemy.die()

func _on_player_took_damage() -> void:
	lives -= 1
	if lives == 0:
		print("Game over")
		player.die()


func _on_enemy_spawner_enemy_spawned(enemy_instance: Enemy) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died() -> void:
	score += 50
	hud.set_score_label(score)
