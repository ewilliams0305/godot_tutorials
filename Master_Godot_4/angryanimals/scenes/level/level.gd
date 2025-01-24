extends Node2D

const ANIMAL = preload("res://scenes/Animal/animal.tscn")

@onready var animal_start: Marker2D = $AnimalStart
@onready var create_animal_timer: Timer = $CreateAnimalTimer

func _ready() -> void:
	SignalManager.on_animal_died.connect(create_animal_timer.start)
	create_animal_timer.timeout.connect(create_animal)
	create_animal()

func _process(delta: float) -> void:
	pass
	
func create_animal() -> void :
	var animal: Animal = ANIMAL.instantiate()
	animal.position = animal_start.position
	add_child(animal)	
