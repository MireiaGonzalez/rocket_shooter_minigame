extends Node2D

var game_over_screen_scene = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var hud = $UI/HUD

var lives: int = 3
var score: int = 0

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(enemy: Enemy) -> void:
	enemy.die()

func _on_player_took_damage() -> void:
	hud.update_lives(lives, 1)
	lives -= 1
	if lives == 0:
		player.die()
		show_game_over_screen()

func _on_enemy_spawner_enemy_spawned(enemy_instance: Enemy) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died() -> void:
	score += 50
	hud.set_score_label(score)

func show_game_over_screen() -> void:
	var game_over_screen_instance: GameOverScreen = game_over_screen_scene.instantiate()
	game_over_screen_instance.set_score(score)
	$UI.add_child(game_over_screen_instance)
