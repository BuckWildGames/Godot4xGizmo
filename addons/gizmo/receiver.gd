extends Node3D
class_name GizmoReceiver
## Receiver node for gizmo addon. Add as child of object you want the gizmo to effect. 
# Target object must be physics object to receive inputs and collide. 
# (CharacterBody3D and RigidBody3D) (StaticBody3D and Area3D will receive inputs but will not collide)
# Node3D can only be selected using a script.

# !!
# Do not edit unless you are prepared for bugs.
# Only edit settings using the inspector.
# Settings for both controller and receiver.
# !!

const DEBUGGER: bool = false

@onready var target: Node3D = get_parent()
@onready var camera : Camera3D = get_viewport().get_camera_3d()

@export_group("Enable Gizmo")
# Uses binary, 0 = none, 7 = all
## Sets whether target can be eddited on each axis.
@export_flags("X", "Y", "Z") var target_can_move: int = 7
## Sets whether target can be eddited on each axis.
@export_flags("X", "Y", "Z") var target_can_rotate: int = 7
## Sets whether target can be eddited on each axis.
@export_flags("X", "Y", "Z") var target_can_scale: int = 7
## Sets whether target can be eddited on each axis.
@export_flags("XY", "YZ", "ZX") var target_can_multi_move: int = 7

@export_group("Setup Receiver")
## Sets whether receiver will get mouse inputs.
@export var receive_input: bool = true
## Sets whether receiver will use the default options or overwite them.
@export var use_default: bool = true
@export_group("Setup Gizmo")
## Sets whether target can collide.
@export var target_collides: bool = false
## Sets custom offset for gizmo on target.
@export var gizmo_offset: Vector3 = Vector3.ZERO

var can_move: Vector3 = Vector3.ONE
var can_rotate: Vector3 = Vector3.ONE
var can_scale: Vector3 = Vector3.ONE
var can_multi_move: Vector3 = Vector3.ONE
var controller: Node3D = null

# Can be called directly or connected to a signal
func call_create_gizmo() -> void:
	# Set debug
	var debug = "GizmoReceiver: Call Create."
	# Check axis enabled
	_convert_to_vector()
	# Check if using default
	if use_default == true:
		# Call to create gizmo
		controller.create_gizmo(target,can_move,can_rotate,can_scale,can_multi_move)
	else:
		# Call to create gizmo
		controller.create_gizmo(target,can_move,can_rotate,can_scale,can_multi_move,target_collides,gizmo_offset)
	_debugger(debug)

# Can be called directly or connected to a signal
func call_clear_gizmo() -> void:
	# Set debug
	var debug = "GizmoReceiver: Call Clear."
	# Call to create gizmo
	controller.clear_gizmo()
	_debugger(debug)

# Should only be called by self
func _ready() -> void:
	# Set debug
	var debug = "GizmoReceiver: Setup: "
	# Check if camera exists
	if camera != null:
		# Check if camera has controller
		for child in camera.get_children():
			if child is GizmoController:
				# Set controller
				controller = child
				# Set debug
				debug += "Controller Found. "
			else:
				# Set debug
				debug += "No Controller Found. "
	else:
		# Set debug
		debug += "No Camera Found. "
	# Check if target exists
	if target != null:
		# Check if target physics body
		if target is CharacterBody3D or target is RigidBody3D or target is Area3D or target is StaticBody3D:
			# Connect to target input
			target.connect("input_event",_on_input_event)
			# Set debug
			debug += "Target Input Event Connected. "
		else:
			# Set debug
			debug += "Target Has No Input Event. "
	else:
		# Set debug
		debug += "No Target Found. "
	_debugger(debug)

# Should only be called by self
func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check if paused
	if receive_input == true:
		# Check event
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					# Set debug
					var debug = "GizmoReceiver: Input Event: "
					# Check if controller set
					if controller != null:
						# Call to create the gizmo
						call_create_gizmo()
						# Set debug
						debug += "Calling Create. "
					else:
						# Set debug
						debug += "No Controller Found. "
					_debugger(debug)

# Should only be called by self
func _convert_to_vector() -> void:
	# Create vector
	var vector = Vector3.ZERO
	# Convert axis enabled to vectors
	for v in 4:
		# Check vector
		match v:
			0:
				# Check axis
				match target_can_move:
					0:
						# Set vector
						vector = Vector3.ZERO
					1:
						# Set vector
						vector = Vector3(1.0, 0.0, 0.0)
					2:
						# Set vector
						vector = Vector3(0.0, 1.0, 0.0)
					3:
						# Set vector
						vector = Vector3(1.0, 1.0, 0.0)
					4:
						# Set vector
						vector = Vector3(0.0, 0.0, 1.0)
					5:
						# Set vector
						vector = Vector3(1.0, 0.0, 1.0)
					6:
						# Set vector
						vector = Vector3(0.0, 1.0, 1.0)
					7:
						# Set vector
						vector = Vector3.ONE
				# Set can move
				can_move = vector
			1:
				# Check axis
				match target_can_rotate:
					0:
						# Set vector
						vector = Vector3.ZERO
					1:
						# Set vector
						vector = Vector3(1.0, 0.0, 0.0)
					2:
						# Set vector
						vector = Vector3(0.0, 1.0, 0.0)
					3:
						# Set vector
						vector = Vector3(1.0, 1.0, 0.0)
					4:
						# Set vector
						vector = Vector3(0.0, 0.0, 1.0)
					5:
						# Set vector
						vector = Vector3(1.0, 0.0, 1.0)
					6:
						# Set vector
						vector = Vector3(0.0, 1.0, 1.0)
					7:
						# Set vector
						vector = Vector3.ONE
				# Set can rotate
				can_rotate = vector
			2:
				# Check axis
				match target_can_scale:
					0:
						# Set vector
						vector = Vector3.ZERO
					1:
						# Set vector
						vector = Vector3(1.0, 0.0, 0.0)
					2:
						# Set vector
						vector = Vector3(0.0, 1.0, 0.0)
					3:
						# Set vector
						vector = Vector3(1.0, 1.0, 0.0)
					4:
						# Set vector
						vector = Vector3(0.0, 0.0, 1.0)
					5:
						# Set vector
						vector = Vector3(1.0, 0.0, 1.0)
					6:
						# Set vector
						vector = Vector3(0.0, 1.0, 1.0)
					7:
						# Set vector
						vector = Vector3.ONE
				# Set can scale
				can_scale = vector
			3:
				# Check axis
				match target_can_multi_move:
					0:
						# Set vector
						vector = Vector3.ZERO
					1:
						# Set vector
						vector = Vector3(1.0, 0.0, 0.0)
					2:
						# Set vector
						vector = Vector3(0.0, 1.0, 0.0)
					3:
						# Set vector
						vector = Vector3(1.0, 1.0, 0.0)
					4:
						# Set vector
						vector = Vector3(0.0, 0.0, 1.0)
					5:
						# Set vector
						vector = Vector3(1.0, 0.0, 1.0)
					6:
						# Set vector
						vector = Vector3(0.0, 1.0, 1.0)
					7:
						# Set vector
						vector = Vector3.ONE
				# Set can move
				can_multi_move = vector

# Should only be called by self
func _debugger(debug_message: String) -> void:
	# Check if script is debug
	if DEBUGGER == true:
		# Check if os debug on
		if OS.is_debug_build():
			# Print message
			print_debug(debug_message)
