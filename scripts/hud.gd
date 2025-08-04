extends Control

@onready var score = $Score
@onready var lives_left = $LivesLeft
var heart_png = preload("res://assets/textures/heart.png")

func set_score_label(new_score: int) -> void:
	score.text = "Score: " + str(new_score)

func set_lives(lives: int) -> void:
	clear_lives()
	
	for x in range(lives):
		var texture_rect = TextureRect.new()
		texture_rect.texture = heart_png
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.custom_minimum_size = heart_png.get_size() * 1.8
		
		$LivesContainer.add_child(texture_rect)

func clear_lives() -> void:
	#Clear any pre-existing lives
	for child in $LivesContainer.get_children():
		child.queue_free()

func update_lives(lives: int, lives_lost: int) -> void:
	var lives_left = lives - lives_lost
	if lives_left <= 0:
		print("here")
		clear_lives()
	else:
		for i in lives_left:
			$LivesContainer.get_child($LivesContainer.get_child_count() -1).queue_free()
		
