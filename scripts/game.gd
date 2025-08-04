extends Node2D

var gos_scene = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHitSound

var lives: int = 3
var score: int = 0

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(enemy: Enemy) -> void:
	enemy.queue_free()

func _on_player_took_damage() -> void:
	player_hit_sound.play()
	hud.update_lives(lives, 1)
	lives -= 1
	if lives == 0:
		player.die()
		await get_tree().create_timer(1.5).timeout
		show_game_over_screen()

func _on_enemy_spawner_enemy_spawned(enemy_instance: Enemy) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died() -> void:
	score += 50
	hud.set_score_label(score)
	enemy_hit_sound.play()

func show_game_over_screen() -> void:
	var gos_instance: GameOverScreen = gos_scene.instantiate()
	gos_instance.set_score(score)
	ui.add_child(gos_instance)
