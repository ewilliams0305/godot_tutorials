extends Node2D

class_name Pipes

const OFF_SCREEN:float = -500.0

@onready var score_sound: AudioStreamPlayer = $ScoreSound

func _ready() -> void:
	SignalManager.on_plane_die.connect(on_plane_died)
	
func check_off_screen() -> void:
	if position.x < OFF_SCREEN:
		queue_free()
		
func _process(delta: float) -> void:
	position.x -= delta * GameManager.SCROLL_SPEED
	check_off_screen()
	
func _on_screen_exited() -> void:
	queue_free()

func on_plane_died() -> void :
	print("PIPES: plane died")
	set_process(false)

func _on_pipe_entered(body: Node2D) -> void:
	print("PIPES: Body Hit %s" % body.name)
	
	if body is Tappy:
		body.die()
	# MANAGE VIA GROUPS FROM THE PROPERTIES PANE
	# Plane is added to groups
	#if body.is_in_group(GameManager.GROUP_PLANE	):
		#if body.has_method("die"):
			#body.die()

func _on_lazer_body_entered(body: Node2D) -> void:
	if body is Tappy:
		score_sound.play()
		ScoreManager.increment_score()
