extends Control

@onready var high_score: Label = $Margin/HighScore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score.text = "%d" % (ScoreManager.get_high_score())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()
