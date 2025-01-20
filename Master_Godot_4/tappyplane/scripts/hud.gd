extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var heigh_score: Label = $MarginContainer/MarginContainer/HeighScore
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalManager.on_score_updated.connect(_on_score_updated)
	SignalManager.on_heigh_score_reached.connect(_on_heigh_score)

func _on_score_updated(score: int) -> void:
	score_label.text = "%d" % score

func _on_heigh_score() -> void:
	animation_player.play("heigh_score")
