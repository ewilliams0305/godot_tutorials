extends Area2D

@export var speed: float = 60.0
@export var paddle_delta: int = 200

func is_off_left() -> bool :
	return position.x < -paddle_delta

func is_off_right() -> bool :
	return position.x > get_viewport_rect().size.x + paddle_delta
	
func _process(delta: float) -> void:
	
	var super_speed: float;
	if Input.is_action_pressed("super_speed") :
		super_speed = speed * 2
	else :
		super_speed = speed
	
	if is_off_left():
		position.x = get_viewport_rect().size.x + paddle_delta
	elif is_off_right():
		position.x = -paddle_delta
	else:
		position.x += delta * super_speed * Input.get_axis("left", "right")
	
