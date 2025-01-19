extends Node2D

const EXPLODE = preload("res://assets/explode.wav")
const SPELL = preload("res://assets/spell1_0.wav")
const MAX_LIVES: int = 3

@export var gem_scene : PackedScene

@onready var score_label : Label = $Score
@onready var lives_label : Label = $Lives
@onready var timer : Timer = $Timer
@onready var sounds: AudioStreamPlayer2D = $sound_fx

var _score: int = 0
var _lives: int = MAX_LIVES

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		restart_game()

func spawn_gem() -> void:
	var new_gem: Gem = gem_scene.instantiate()
	new_gem.on_gem_off_sreen.connect(lost_life)
	
	var xpos : float = randf_range(70, 1050)
	new_gem.position = Vector2(xpos, -50)
	new_gem.speed = randf_range(30, 500)
	new_gem.rotation_rate = randf_range(0, 5)
	add_child(new_gem)
	
func restart_game() -> void:
	sounds.stream = SPELL
	_score = 0
	_lives = MAX_LIVES
	score_label.text = "SCORE: %03d" % _score
	lives_label.text = "LIVES: %d" % _lives
	
	for child in get_children():
		child.set_process(true)	
	timer.start();


func stop_all() -> void:
	timer.stop();

	for child in get_children():
		child.set_process(false)

func play_dead() -> void:
	sounds.stop()
	sounds.stream = EXPLODE
	sounds.play()

func play_spell() -> void:
	sounds.stop()
	sounds.stream = SPELL
	sounds.play()


func lost_life() -> void:
	_lives -= 1
	lives_label.text = "LIVES: %d" % _lives
	play_dead()

	if _lives == 0 :
		game_over()
	
func game_over() -> void:
	print("game over")
	stop_all()
	_score = 0

func _ready() -> void:
	spawn_gem()
	
func _on_timer_timeout() -> void:
	print("Timer Timedout")
	spawn_gem()

func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	
	sounds.position = area.position
	play_spell()
	score_label.text = "SCORE: %03d" % _score
	area.queue_free()
