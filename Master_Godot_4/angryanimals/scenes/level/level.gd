extends Node2D

const ANIMAL = preload("res://scenes/Animal/animal.tscn")
const MAIN = preload("res://scenes/ui/main.tscn")

@onready var animal_start: Marker2D = $AnimalStart
@onready var create_animal_timer: Timer = $CreateAnimalTimer

func _ready() -> void:
	SignalManager.on_animal_died.connect(create_animal_timer.start)
	create_animal_timer.timeout.connect(create_animal)
	create_animal()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		print("Exit to Main")
		get_tree().change_scene_to_packed(MAIN)
	
func create_animal() -> void :
	var animal: Animal = ANIMAL.instantiate()
	animal.position = animal_start.position
	add_child(animal)	
