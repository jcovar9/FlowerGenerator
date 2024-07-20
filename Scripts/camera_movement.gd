extends Camera3D

@export
var flower_grower : Marker3D

var prev_mouse_position : Vector2
var next_mouse_position : Vector2
var rotating := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func handle_flower_rotation(delta: float) -> void:
	if(rotating):
		next_mouse_position = get_viewport().get_mouse_position()
		flower_grower.rotate_y((next_mouse_position.x - prev_mouse_position.x) * delta * 0.5)
		prev_mouse_position = next_mouse_position
	
	if(Input.is_action_just_pressed("LeftMouseClick")):
		rotating = true
		prev_mouse_position = get_viewport().get_mouse_position()
	if(Input.is_action_pressed("LeftMouseClick")):
		prev_mouse_position = get_viewport().get_mouse_position()
	if(Input.is_action_just_released("LeftMouseClick")):
		rotating = false

func handle_camera_zoom() -> void:
	if(Input.is_action_just_pressed("ZoomIn")):
		position *= 0.9
	if(Input.is_action_just_pressed("ZoomOut")):
		position *= 1.1

func _physics_process(delta: float) -> void:
	handle_flower_rotation(delta)
	handle_camera_zoom()
