extends Camera3D

## Simple free cam script


@export var move_speed: float = 10.0
@export var sensitivity: float = 0.5
@export var max_pitch: float = 80.0

var speed: float = move_speed
var pitch: float = 0.0
var yaw: float = 0.0
var pivot: bool = false

var hint: bool = false


func _input(event: InputEvent) -> void:
	# Check if right click pressed
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				# Set pivot
				pivot = true
			else:
				# Set pivot
				pivot = false
	if event is InputEventKey:
		# Check if enter pressed
		if event.keycode == KEY_ENTER:
			if event.is_pressed():
				# Select Node3D
				get_parent().get_parent().get_node("Objects/Node3D/GizmoReceiver").call_create_gizmo()
		# Check if escape pressed
		if event.keycode == KEY_ESCAPE:
			if event.is_pressed():
				# Check if hint
				if hint == false:
					# Hide ui
					get_parent().get_parent().get_node("UI/CanvasLayer").hide()
				# Clear the gizmo
				get_node("GizmoController").clear_gizmo()
		# Check if shift pressed
		if event.keycode == KEY_SHIFT:
			if event.is_pressed():
				# Adjust move speed
				speed = move_speed * 2
			else:
				speed = move_speed
	# Check if pivoting
	if pivot == true:
		if event is InputEventMouseMotion:
			# Rotate camera with mouse
			yaw -= event.relative.x * sensitivity
			pitch = clamp(pitch - event.relative.y * sensitivity, -max_pitch, max_pitch)
			rotation_degrees = Vector3(pitch, yaw, 0)

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	# Get direction inputs
	if Input.is_key_pressed(KEY_W):
		direction -= transform.basis.z
	if Input.is_key_pressed(KEY_S):
		direction += transform.basis.z
	if Input.is_key_pressed(KEY_A):
		direction -= transform.basis.x
	if Input.is_key_pressed(KEY_D):
		direction += transform.basis.x
	if Input.is_key_pressed(KEY_SPACE):
		direction += Vector3.UP
	if Input.is_key_pressed(KEY_CTRL):
		direction -= Vector3.UP
	# Check if direction set
	if direction.length() > 0:
		# Move in direction
		direction = direction.normalized() * speed * delta
		global_transform.origin += direction
