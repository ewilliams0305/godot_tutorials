extends TextureButton

const HOVER_SCALE: Vector2 = Vector2(1.1, 1.1)
const RESET_SCALE: Vector2 = Vector2(1, 1)

@export var level_number:int = 1

@onready var level: Label = $Margin/VBoxContainer/Level
@onready var score: Label = $Margin/VBoxContainer/Score


var _level_scene: PackedScene

func _ready() -> void:
	level.text = str(level_number)
	_level_scene = load("res://scenes/level/level%s.tscn" % level_number)

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(_level_scene)

func _on_mouse_entered() -> void:
	scale = HOVER_SCALE

func _on_mouse_exited() -> void:
	scale = RESET_SCALE
