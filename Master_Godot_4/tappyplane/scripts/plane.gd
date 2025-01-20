extends CharacterBody2D

class_name Tappy

const GRAVITY: float = 1000.0
const POWER: float = 350.0


@onready var engine_sound: AudioStreamPlayer2D = $EngineSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation: AnimatedSprite2D = $Animation
@onready var timer: Timer = $SoundTImer


const EXPLODE = preload("res://assets/audio/explode.wav")

func _ready() -> void:
	pass 

func fly()-> void :
	if Input.is_action_just_pressed("fly"):
		velocity.y -= POWER
		animation_player.play("pull_up")
		engine_sound.pitch_scale = 1.1
		timer.stop()
		timer.start()
	
func die() -> void:
	animation.stop()
	engine_sound.stop()
	engine_sound.stream = EXPLODE
	engine_sound.play()
	set_physics_process(false)
	SignalManager.on_plane_die.emit()
	
func _physics_process(delta: float) -> void:

	velocity.y += GRAVITY * delta
	fly()	
	move_and_slide()

	if is_on_floor():
		die()

func _on_timer_timeout() -> void:
	engine_sound.pitch_scale = .6
