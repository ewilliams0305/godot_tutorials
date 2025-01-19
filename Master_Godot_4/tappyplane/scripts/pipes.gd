extends Node2D

class_name Pipes

@export var speed: float = 120.0

func is_off_screen() -> void:
	if position.x < -500:
		queue_free()
		
func _process(delta: float) -> void:
	position.x -= delta * speed
	is_off_screen()
	
func _on_screen_exited() -> void:
	queue_free()
