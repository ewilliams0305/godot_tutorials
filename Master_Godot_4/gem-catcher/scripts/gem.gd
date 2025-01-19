extends Area2D

class_name Gem

signal on_gem_off_sreen

@export var speed: float = 100.0
@export var rotation_rate: float = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y += speed * delta
	rotation += rotation_rate * delta
	
	if position.y > (get_viewport_rect().size.y + 20):
		print("removing gem")
		on_gem_off_sreen.emit()
		set_process(false)
		queue_free()
