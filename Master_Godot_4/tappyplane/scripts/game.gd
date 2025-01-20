extends Node2D

const PIPES: PackedScene = preload("res://scenes/pipes.tscn")

@onready var spawn_btm: Marker2D = $SpawnBtm
@onready var spawn_top: Marker2D = $SpawnTop
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node2D = $PipesHolder

func _ready() -> void:
	ScoreManager.set_score(0)
	SignalManager.on_plane_die.connect(_on_plane_die)
	spawn_pipes()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var yp: float = randf_range(spawn_top.position.y, spawn_btm.position.y)
	new_pipes.position = Vector2(spawn_btm.position.x, yp)	
	pipes_holder.add_child(new_pipes)

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func _on_plane_die() -> void:
	print("GAME: plane died")
	spawn_timer.stop()
