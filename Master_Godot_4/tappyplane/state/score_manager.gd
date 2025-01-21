extends Node

const SCORES_PATH: String = "user://tappy.dat"

var _score: int = 0
var _high_score: int = 0

func _ready() -> void:
	load_heigh_score()
	SignalManager.on_plane_die.connect(save_score)
	pass 

func get_score() -> int :
	return _score
	
func get_high_score() -> int :
	return _high_score
	
func set_score(v: int) -> void :
	_score = v
	if _score > _high_score :
		_high_score = _score
		SignalManager.on_heigh_score_reached.emit()
		
	SignalManager.on_score_updated.emit(_score)
		
func increment_score() -> void :
	set_score(_score + 1)
		
func load_heigh_score() -> void:
	var file = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0 :
			_high_score = file.get_32()
			print("read heigh score")
		
		file.close()
	else: 
		print("failed to open file")
		
func save_score() -> void:
	var file = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	
	if file:
		file.store_32(_high_score)
		print("saved heigh score")
		file.close()
	else: 
		print("failed to open file")
	
	
