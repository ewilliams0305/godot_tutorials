extends Control

func switch_scene() -> void :
	GameManager.goto_next_scene()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
