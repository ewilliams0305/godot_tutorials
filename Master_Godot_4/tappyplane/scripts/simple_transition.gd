extends Control


func _on_timer_timeout() -> void:
	GameManager.goto_next_scene()
