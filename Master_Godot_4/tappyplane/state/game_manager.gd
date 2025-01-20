extends Node

const GAME: PackedScene = preload("res://scenes/game.tscn")
const MAIN = preload("res://scenes/main.tscn")

const SCROLL_SPEED: float = 120.0
const GROUP_PLANE: String = "Plane"

func load_game_scene() -> void :
	get_tree().change_scene_to_packed(GAME)
	
func load_menu_scene() -> void :
	get_tree().change_scene_to_packed(MAIN)
