extends Area2D

@export var speed: float = 100.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > (get_viewport_rect().size.y + 20):
		print("removing gem")
		set_process(false)
		queue_free()
