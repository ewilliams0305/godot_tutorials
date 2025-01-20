extends Control
@onready var game_over_label: Label = $GameOverLabel
@onready var space_label: Label = $SpaceLabel
@onready var show_space_timer: Timer = $ShowSpaceTimer
@onready var sound: AudioStreamPlayer = $Sound


func _ready() -> void:
	hide()
	game_over_label.show()
	space_label.hide()
	SignalManager.on_plane_die.connect(_on_plane_die)

func _process(delta: float) -> void:
	if space_label.visible and Input.is_action_just_pressed("fly"):
		GameManager.load_menu_scene()

func _on_show_space_timer_timeout() -> void:
	game_over_label.hide()
	space_label.show()

func _on_plane_die() -> void:
	print("GAME_OVER: plane died")
	show_space_timer.start()
	sound.play()
	show()
	
