extends Area2D

@export var speed: float = 60.0
@export var paddle_delta: int = 200

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		if position.x > -paddle_delta:
			position.x -= speed * delta
		else:
			position.x = get_viewport_rect().size.x + paddle_delta
		
	elif Input.is_action_pressed("right"):

		if position.x > get_viewport_rect().size.x + paddle_delta:
			position.x = -paddle_delta
		else:
			position.x += speed * delta
			
		
