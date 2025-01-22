extends Node

const GAME: PackedScene = preload("res://scenes/game.tscn")
const MAIN = preload("res://scenes/main.tscn")
const SIMPLE_TRANSITION = preload("res://scenes/simple_transition.tscn")
const COMPLEX_TRANSITION = preload("res://scenes/complex_transition.tscn")

const SCROLL_SPEED: float = 120.0
const GROUP_PLANE: String = "Plane"

var level: int = 1
var speed: float = 120.0
var time: float = 1.2

func load_game_scene() -> void :
	get_tree().change_scene_to_packed(GAME)
	#load_next_scene(GAME)
	
func load_menu_scene() -> void :
	get_tree().change_scene_to_packed(MAIN)

# REMOVED BUT EXAMPLE OF SWITCHING TO FADES AND LOADING
var next_scene: PackedScene

func goto_next_scene()-> void:
	get_tree().change_scene_to_packed(next_scene)
#
#var next_scene: PackedScene
#
#func goto_next_scene()-> void:
	#get_tree().change_scene_to_packed(next_scene)
#
#func load_next_scene(ns: PackedScene)-> void:
	#next_scene = ns
	##get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	#var ctx = COMPLEX_TRANSITION.instantiate()
	#add_child(ctx)
#
#func load_game_scene() -> void :
	##get_tree().change_scene_to_packed(GAME)
	#load_next_scene(GAME)
	#
#func load_menu_scene() -> void :
	##get_tree().change_scene_to_packed(MAIN)
	#load_next_scene(MAIN)
