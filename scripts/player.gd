extends CharacterBody2D

var sprite_size: Vector2
const speed: int = 300
var rocket_scene = preload("res://scenes/rocket.tscn")
@onready var rocket_container = $RocketContainer

func _ready() -> void:
	var sprite := $PlayerTexture
	#Because the anchor point for the sprite is at its center, the sprite size needs to be halfed
	sprite_size = (sprite.texture.get_size() * sprite.scale)/2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
		
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(sprite_size, screen_size - sprite_size)

func shoot() -> void:
	var rocket_instance = rocket_scene.instantiate()
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	rocket_container.add_child(rocket_instance)
