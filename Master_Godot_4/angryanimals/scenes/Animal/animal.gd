extends RigidBody2D

class_name Animal
@onready var debug: Label = $Debug
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound
@onready var arrow: Sprite2D = $Arrow
@onready var kick_sound: AudioStreamPlayer2D = $KickSound

enum ANAIMAL_STATE { READY, DRAG, RELEASE }

const DRAG_LIMIT_MAX : Vector2 = Vector2(0, 60)
const DRAG_LIMIT_MIN : Vector2 = Vector2(-60, 0)
const IMPULSE_MULT : float = 20.0
const IMPULSE_MAX : float = 1200.0

var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _last_dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0
var _last_collision_count: int = 0

var _state: ANAIMAL_STATE = ANAIMAL_STATE.READY

func _ready() -> void:
	_arrow_scale_x = arrow.scale.x
	arrow.hide()
	_start = position

func _physics_process(delta: float) -> void:
	update(delta)
	debug.text = "%s" % ANAIMAL_STATE.keys()[_state]
	debug.text += "\n%.1f, %.1f" % [_dragged_vector.x, _dragged_vector.y]

# CHANGE OUR ANIMALS STATE
func set_new_state(new_state: ANAIMAL_STATE) -> void:
	_state = new_state	
	
	match _state :
		ANAIMAL_STATE.RELEASE:
			arrow.hide()
			freeze = false
			apply_central_impulse(get_impulse())
			launch_sound.play()
			SignalManager.on_attempt_made.emit()
		ANAIMAL_STATE.DRAG:
			arrow.show()
			_drag_start = get_global_mouse_position()
	
func get_impulse()-> Vector2:
	return _dragged_vector * -1 * IMPULSE_MULT

# HANDLE THE READY STATE CHANGE
func update_ready(delta: float) -> void:
	pass
	
# HANDLE THE DRAGGED STATE CHANGE	
func detect_release() -> bool:
	return _state == ANAIMAL_STATE.DRAG and Input.is_action_just_released("drag")

func scale_arrow() -> void :
	var impl_len = get_impulse().length()
	var perc = impl_len / IMPULSE_MAX
	
	arrow.scale.x = (_arrow_scale_x * perc) + _arrow_scale_x
	arrow.rotation = (_start - position).angle()
	
func play_stretch_sound() -> void:
	if(_last_dragged_vector - _dragged_vector).length() > 0:
		if stretch_sound.playing == false:
			stretch_sound.play()

func get_dragged_vector(gmp: Vector2) -> Vector2:
	return gmp - _drag_start

func drag_in_limits() -> void:
	_last_dragged_vector = _dragged_vector
	
	_dragged_vector.x = clampf(
		_dragged_vector.x, 
		DRAG_LIMIT_MIN.x, 
		DRAG_LIMIT_MAX.x)
	_dragged_vector.y = clampf(
		_dragged_vector.y, 
		DRAG_LIMIT_MIN.y, 
		DRAG_LIMIT_MAX.y)
	
	position = _start + _dragged_vector

func update_drag(delta: float) -> void:
	
	if detect_release():
		return
		
	var gmp = get_global_mouse_position()
	_dragged_vector = get_dragged_vector(gmp)
	play_stretch_sound()
	drag_in_limits()
	scale_arrow()
	print(_start, _drag_start, _dragged_vector)

func update_flight() -> void:
	pass
	#
	#var count: int = get_contact_count()
	#
	#if _last_collision_count == 0 and count > 0 and kick_sound.playing == false:
		#kick_sound.play()
		#
	#_last_collision_count = count
		

# HANDLE RELEASE STATE
func update_release(delta: float) -> void:
	update_flight()


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


# SIGNAL INVOCATIONS
func die() -> void :
	queue_free()
	SignalManager.on_animal_died.emit()

# SIGNAL HANDLERS
func _on_visible_on_screen_notifier_screen_exited() -> void:
	die()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(event)
	if _state == ANAIMAL_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(ANAIMAL_STATE.DRAG)
	elif _state == ANAIMAL_STATE.DRAG and event.is_action_released("drag"):
		set_new_state(ANAIMAL_STATE.RELEASE)
		
func _on_sleeping_state_changed() -> void:
	if sleeping == true:
		var bodies = get_colliding_bodies()
		if bodies.size() > 0 :
			bodies[0].die()
			
		call_deferred("die")

func _on_body_entered(body: Node) -> void:
	if kick_sound.playing == false:
		kick_sound.play()
