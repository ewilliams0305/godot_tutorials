extends RigidBody2D

class_name Animal
@onready var debug: Label = $Debug

enum ANAIMAL_STATE { READY, DRAG, RELEASE }

const DRAG_LIMIT_MAX : Vector2 = Vector2(0, 60)
const DRAG_LIMIT_MIN : Vector2 = Vector2(-60, 0)

var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _drag_vector: Vector2 = Vector2.ZERO

var _state: ANAIMAL_STATE = ANAIMAL_STATE.READY


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	update(delta)
	debug.text = "%s" % ANAIMAL_STATE.keys()[_state]

func update_ready(delta: float) -> void:
	pass
	
func set_new_state(new_state: ANAIMAL_STATE) -> void:
	_state = new_state	
	if _state == ANAIMAL_STATE.RELEASE:
		freeze = false
	elif _state == ANAIMAL_STATE.DRAG:
		pass
	
func detect_release() -> bool:
	return _state == ANAIMAL_STATE.DRAG and Input.is_action_just_released("drag")
	
func get_dragged_vector(gmp: Vector2) -> Vector2:
	return gmp - _drag_start

func drag_in_limits() -> void:
	_drag_vector.x = clampf(_drag_vector.x, DRAG_LIMIT_MIN.x, DRAG_LIMIT_MAX.x)
	_drag_vector.y = clampf(_drag_vector.y, DRAG_LIMIT_MIN.y, DRAG_LIMIT_MAX.y)
	
	position = _start + _drag_vector

func update_drag(delta: float) -> void:
	
	if detect_release():
		return
		
	var gmp = get_global_mouse_position()
	_drag_vector = get_dragged_vector(gmp)
	drag_in_limits()

func update_release(delta: float) -> void:
	pass

func update(delta: float) -> void:
	match _state :
		ANAIMAL_STATE.READY:
			update_ready(delta)
			pass
		ANAIMAL_STATE.DRAG:
			update_drag(delta)
			pass
		ANAIMAL_STATE.RELEASE:
			update_release(delta)
			pass

func die() -> void :
	queue_free()
	SignalManager.on_animal_died.emit()

func _on_visible_on_screen_notifier_screen_exited() -> void:
	die()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _state == ANAIMAL_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(ANAIMAL_STATE.DRAG)
	elif _state == ANAIMAL_STATE.DRAG and event.is_action_released("drag"):
		set_new_state(ANAIMAL_STATE.RELEASE)
		
