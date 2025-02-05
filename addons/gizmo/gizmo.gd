extends Node3D

# !!
# Do not edit unless you are prepared for bugs.
# Only edit settings using the inspector.
# Settings for both controller and receiver.
# !!

const DEBUGGER: bool = false
const PROCESS_DEBUGGER: bool = false

# Default colours
const X_COLOUR: Color = Color.RED
const Y_COLOUR: Color = Color.GREEN
const Z_COLOUR: Color = Color.BLUE
const SELECTED_COLOUR: Color = Color.YELLOW

# Refrences for all axis
@onready var scaler: Node3D = $Scaler
@onready var center: MeshInstance3D = $Scaler/Center/Ball
@onready var x_arm: MeshInstance3D = $Scaler/Positions/X/Arm
@onready var x_arrow: MeshInstance3D = $Scaler/Positions/X/Arrow
@onready var y_arm: MeshInstance3D = $Scaler/Positions/Y/Arm
@onready var y_arrow: MeshInstance3D = $Scaler/Positions/Y/Arrow
@onready var z_arm: MeshInstance3D = $Scaler/Positions/Z/Arm
@onready var z_arrow: MeshInstance3D = $Scaler/Positions/Z/Arrow
@onready var x_ring: MeshInstance3D = $Scaler/Rotations/X/Ring
@onready var y_ring: MeshInstance3D = $Scaler/Rotations/Y/Ring
@onready var z_ring: MeshInstance3D = $Scaler/Rotations/Z/Ring
@onready var x_cube: MeshInstance3D = $Scaler/Scales/X/Cube
@onready var y_cube: MeshInstance3D = $Scaler/Scales/Y/Cube
@onready var z_cube: MeshInstance3D = $Scaler/Scales/Z/Cube
@onready var xy_x_piece: MeshInstance3D = $Scaler/MultiPositions/XY/XPiece
@onready var xy_y_piece: MeshInstance3D = $Scaler/MultiPositions/XY/YPiece
@onready var yz_y_piece: MeshInstance3D = $Scaler/MultiPositions/YZ/YPiece
@onready var yz_z_piece: MeshInstance3D = $Scaler/MultiPositions/YZ/ZPiece
@onready var zx_z_piece: MeshInstance3D = $Scaler/MultiPositions/ZX/ZPiece
@onready var zx_x_piece: MeshInstance3D = $Scaler/MultiPositions/ZX/XPiece

# Vars for all options
var colours: Array = [X_COLOUR, Y_COLOUR, Z_COLOUR, SELECTED_COLOUR]
var old_target: Node3D = null
var target: Node3D = null
var controller: Node3D = null
var old_collides: bool = false
var collides: bool = false
var always_visible: bool = true
var always_update: bool = false
var offset: Vector3 = Vector3.ZERO
var scale_multiplier: float = 0.5
var alpha: float = 0.7
var axis: Array = [false, false, false, false, false, false, false, false, false, false, false, false]
var old_positon: Vector2 = Vector2.ZERO
var step: float = 5.0
var stored_delta: float = 0.0
var movement: Vector3 = Vector3.ZERO
var rotate: Vector3 = Vector3.ZERO
var scaled: Vector3 = Vector3.ZERO
var default_inverts: Dictionary = {
	"xpos": false, "ypos": false, "zpos": false,
	"xrot": false, "yrot": false, "zrot": false,
	"xscl": false, "yscl": false, "zscl": false,
	"xyx": false, "xyy": false, "yzy": false,
	"yzz": false, "zxz": false, "zxx": false
}
var invert_axis: Dictionary = default_inverts.duplicate()

# Should only be called by self
func _ready() -> void:
	# Setup target
	_setup_target(target)
	# Connect signal
	connect("tree_exiting",_reset_target)

# Should only be called by self
func _input(event: InputEvent) -> void:
	# Set debug
	var debug = ""
	# Check if moving
	if _check_moving() == true:
		# Check event
		if event is InputEventMouseMotion:
			# Get move distance
			var distance = event.position.distance_to(old_positon)
			var direction = (event.position - old_positon).normalized()
			var move_amount = step * stored_delta
			# Check movement
			if move_amount > distance:
				move_amount = distance
			var move = direction * move_amount
			var m = move.x + move.y
			# Check if axis is unlocked
			if axis[0] == true:
				# Check inverted
				if invert_axis["xpos"] == true:
					# Move target
					movement.x = -m
				else:
					# Move target
					movement.x = m
				# Set debug
				debug += "Gizmo: Moving X: " +str(m)
			elif axis[1] == true:
				# Check inverted
				if invert_axis["ypos"] == true:
					# Move target
					movement.y = -m
				else:
					# Move target
					movement.y = m
				# Set debug
				debug += "Gizmo: Moving Y: " +str(m)
			elif axis[2] == true:
				# Check inverted
				if invert_axis["zpos"] == true:
					# Move target
					movement.z = -m
				else:
					# Move target
					movement.z = m
				# Set debug
				debug += "Gizmo: Moving Z: " +str(m)
			elif axis[3] == true:
				# Check inverted
				if invert_axis["xrot"] == true:
					# Rotate target
					rotate.x = -m
				else:
					# Rotate target
					rotate.x = m
				# Set debug
				debug += "Gizmo: Rotating X: " +str(m)
			elif axis[4] == true:
				# Check inverted
				if invert_axis["yrot"] == true:
					# Rotate target
					rotate.y = -m
				else:
					# Rotate target
					rotate.y = m
				# Set debug
				debug += "Gizmo: Rotating Y: " +str(m)
			elif axis[5] == true:
				# Check inverted
				if invert_axis["zrot"] == true:
					# Rotate target
					rotate.z = -m
				else:
					# Rotate target
					rotate.z = m
				# Set debug
				debug += "Gizmo: Rotating Z: " +str(m)
			elif axis[6] == true:
				# Check inverted
				if invert_axis["xscl"] == true:
					# Scale target
					scaled.x = -m
				else:
					# Scale target
					scaled.x = m
				# Set debug
				debug += "Gizmo: Scaling X: " +str(m)
			elif axis[7] == true:
				# Check inverted
				if invert_axis["yscl"] == true:
					# Scale target
					scaled.y = -m
				else:
					# Scale target
					scaled.y = m
				# Set debug
				debug += "Gizmo: Scaling Y: " +str(m)
			elif axis[8] == true:
				# Check inverted
				if invert_axis["zscl"] == true:
					# Scale target
					scaled.z = -m
				else:
					# Scale target
					scaled.z = m
				# Set debug
				debug += "Gizmo: Scaling Z: " +str(m)
			elif axis[9] == true:
				# Check inverted
				if invert_axis["xyx"] == true:
					# Move target
					movement.x = -move.x
				else:
					# Move target
					movement.x = move.x
				# Check inverted
				if invert_axis["xyy"] == true:
					# Move target
					movement.y = -move.y
				else:
					# Move target
					movement.y = move.y
				# Set debug
				debug += "Gizmo: Moving XY: " +str(m)
			elif axis[10] == true:
				# Check inverted
				if invert_axis["yzy"] == true:
					# Move target
					movement.y = -move.y
				else:
					# Move target
					movement.y = move.y
				# Check inverted
				if invert_axis["yzz"] == true:
					# Move target
					movement.z = -move.x
				else:
					# Move target
					movement.z = move.x
				# Set debug
				debug += "Gizmo: Moving YZ: " +str(m)
			elif axis[11] == true:
				# Check inverted
				if invert_axis["zxz"] == true:
					# Move target
					movement.z = -move.y
				else:
					# Move target
					movement.z = move.y
				# Check inverted
				if invert_axis["zxx"] == true:
					# Move target
					movement.x = -move.x
				else:
					# Move target
					movement.x = move.x
				# Set debug
				debug += "Gizmo: Moving ZX: " +str(m)
		elif event is InputEventMouseButton:
			# Check if click released
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_released():
					# Reset
					movement = Vector3.ZERO
					rotate = Vector3.ZERO
					scaled = Vector3.ZERO
					# Reset axis
					for a in axis.size():
						axis[a] = false
					# Reset
					_reset_colours()
					_reset_position()
					# Set debug
					debug += " Gizmo: Axis Released."
	# Check if debug
	if debug != "":
		_debugger(debug)

# Should only be called by self
func _physics_process(delta: float) -> void:
	# Set debug
	var debug = "Gizmo Physics Process: "
	# Check if target set
	if target != null:
		# Check if controller set
		if controller != null:
			# Set stored delta
			stored_delta = delta
			# Check if moving at all
			if _check_moving() == false:
				# Check if position matches target
				if get_global_position() != target.get_global_position() + offset:
					# Reset position
					_reset_position()
			# Check if moving
			if movement != Vector3.ZERO:
				# Check if collides
				if collides == false:
					# Move target
					target.global_translate(movement)
				else:
					# Check if rigidbody
					if target is RigidBody3D:
						# Apply force
						target.apply_central_impulse(movement * (step * 10))
						# Wait for force to be applied
						await get_tree().physics_frame
						# Freeze movement
						target.set_linear_velocity(Vector3.ZERO)
						target.set_angular_velocity(Vector3.ZERO)
					# Check if characterbody
					elif target is CharacterBody3D:
						# Move and collide
						target.move_and_collide(movement)
					else:
						# Move target
						target.global_translate(movement)
				# Check if always update
				if always_update == true:
					# Update position
					_reset_position()
				# Set debug
				debug += "Moving Target. "
			# Check if rotating
			elif rotate != Vector3.ZERO:
				# Check if collides
				if collides == false:
					# Rotate target
					target.global_rotate(rotate.normalized(),step * 0.005)
				else:
					# Check if rigidbody
					if target is RigidBody3D:
						# Apply torque
						target.apply_torque_impulse(rotate * step)
						# Wait for force to be applied
						await get_tree().physics_frame
						# Freeze movement
						target.set_linear_velocity(Vector3.ZERO)
						target.set_angular_velocity(Vector3.ZERO)
					elif target is CharacterBody3D:
						# Save current rotation
						var rot = target.get_global_rotation()
						# Set rotation
						target.global_rotate(rotate.normalized(),step * 0.005)
						# Check for collisions
						if target.move_and_collide(Vector3.ZERO,true):
							# Reset rotation
							target.set_global_rotation(rot)
					else:
						# Rotate target
						target.global_rotate(rotate.normalized(),step * 0.005)
				# Set debug
				debug += "Rotating Target. "
			# Check if scaling
			elif scaled != Vector3.ZERO:
				# Set vars
				var mesh = []
				var col = []
				# Find mesh and collision nodes
				for child in target.get_children():
					if child is MeshInstance3D:
						mesh.append(child)
					elif child is CollisionShape3D or child is CollisionPolygon3D:
						col.append(child)
				# Check to see if it exists
				if mesh.size() != 0 or col.size() != 0:
					# Check axis
					if scaled.x != 0:
						# Scale mesh
						for s in mesh.size():
							# Scale target
							mesh[s].scale.x += scaled.x * 0.5
						# Scale collison
						for s in col.size():
							# Scale target
							col[s].scale.x += scaled.x * 0.5
					elif scaled.y != 0:
						# Scale mesh
						for s in mesh.size():
							# Scale target
							mesh[s].scale.y += scaled.y * 0.5
						# Scale collison
						for s in col.size():
							# Scale target
							col[s].scale.y += scaled.y * 0.5
					elif scaled.z != 0:
						# Scale mesh
						for s in mesh.size():
							# Scale target
							mesh[s].scale.z += scaled.z * 0.5
						# Scale collison
						for s in col.size():
							# Scale target
							col[s].scale.z += scaled.z * 0.5
					# Set debug
					debug += "Scaling Target. "
				else:
					# Set debug
					debug += "No Mesh or Collider To Scale. "
			else:
				# Set debug
				debug = ""
		else:
			# Set debug
			debug += "No Controller Found."
	else:
		# Set debug
		debug += "No Target Found."
	# Check debug
	if PROCESS_DEBUGGER == true and debug != "":
		_debugger(debug)

# Should only be called by self
func _process(_delta: float) -> void:
	# Set debug
	var debug = "Gizmo Process: "
	# Check if target set
	if target != null:
		# Check if controller set
		if controller != null:
			# Check old target
			if old_target != target:
				# Reset old target
				_reset_target(old_target, old_collides)
				# Setup target
				_setup_target(target, collides)
				# Set debug
				debug += "Target Changed. "
			# Set vars
			var pos = get_global_position()
			var c_pos = controller.get_global_position()
			var ss = scaler.get_scale()
			var new_ss
			# Get distance from controller
			var distance = pos.distance_to(c_pos)
			# Set scale based on distance
			new_ss = Vector3(distance * scale_multiplier, distance * scale_multiplier, distance * scale_multiplier)
			# Check if changed
			if ss != new_ss:
				# Set
				scaler.set_scale(new_ss)
				# Set debug
				debug += "Distance: " +str(distance) +" Scale: " +str(new_ss)
			# Check controller position vs gizmo position
			var s = get_scale()
			var r = get_global_rotation()
			var i = default_inverts.duplicate()
			var new_s
			var new_r
			if pos.x > c_pos.x:
				if pos.y > c_pos.y:
					if pos.z > c_pos.z:
						#print("X> Y> Z>")
						# Set
						i["xpos"] = true
						i["ypos"] = true
						i["zscl"] = true
						i["xyx"] = true
						i["xyy"] = true
						i["yzy"] = true
						i["zxx"] = true
						new_s = Vector3(-1.0,-1.0,-1.0)
						new_r = Vector3.ZERO
					else:
						#print("X> Y> Z<")
						# Set
						i["ypos"] = true
						i["zrot"] = true
						i["xscl"] = true
						i["xyy"] = true
						i["yzy"] = true
						i["zxz"] = true
						new_s = Vector3(1.0,1.0,1.0)
						new_r = Vector3(deg_to_rad(180.0),deg_to_rad(180.0),0.0)
				elif pos.z > c_pos.z:
					#print("X> Y< Z>")
					# Set
					i["xpos"] = true
					i["ypos"] = true
					i["yscl"] = true
					i["zscl"] = true
					i["xyx"] = true
					i["xyy"] = true
					i["yzy"] = true
					i["zxx"] = true
					i["zxz"] = true
					new_s = Vector3(1.0,1.0,1.0)
					new_r = Vector3(0.0,deg_to_rad(180.0),0.0)
				else:
					#print("X> Y< Z<")
					# Set
					i["ypos"] = true
					i["zrot"] = true
					i["xscl"] = true
					i["yscl"] = true
					i["xyy"] = true
					i["yzy"] = true
					new_s = Vector3(-1.0,-1.0,-1.0)
					new_r = Vector3(deg_to_rad(180.0),0.0,0.0)
			elif pos.y > c_pos.y:
				if pos.z > c_pos.z:
					#print("X< Y> Z>")
					# Set
					i["xpos"] = true
					i["ypos"] = true
					i["zpos"] = true
					i["xrot"] = true
					i["xscl"] = true
					i["xyx"] = true
					i["xyy"] = true
					i["yzy"] = true
					i["yzz"] = true
					i["zxx"] = true
					new_s = Vector3(1.0,1.0,1.0)
					new_r = Vector3(deg_to_rad(180.0),0.0,0.0)
				else:
					#print("X< Y> Z<")
					# Set
					i["ypos"] = true
					i["zpos"] = true
					i["xrot"] = true
					i["zrot"] = true
					i["zscl"] = true
					i["xyy"] = true
					i["yzy"] = true
					i["yzz"] = true
					i["zxz"] = true
					new_s = Vector3(-1.0,-1.0,-1.0)
					new_r = Vector3(0.0,deg_to_rad(180.0),0.0)
			elif pos.z > c_pos.z:
				#print("X< Y< Z>")
				# Set
				i["xpos"] = true
				i["ypos"] = true
				i["zpos"] = true
				i["xrot"] = true
				i["xscl"] = true
				i["yscl"] = true
				i["xyx"] = true
				i["xyy"] = true
				i["yzy"] = true
				i["yzz"] = true
				i["zxz"] = true
				i["zxx"] = true
				new_s = Vector3(-1.0,-1.0,-1.0)
				new_r = Vector3(deg_to_rad(180.0),deg_to_rad(180.0),0.0)
			else:
				#print("X< Y< Z<")
				# Set
				i["ypos"] = true
				i["zpos"] = true
				i["xrot"] = true
				i["zrot"] = true
				i["xyy"] = true
				i["yscl"] = true
				i["zscl"] = true
				i["yzy"] = true
				i["yzz"] = true
				new_s = Vector3.ONE
				new_r = Vector3.ZERO
			# Check if changed
			if s != new_s or r != new_r:
				# Set
				invert_axis = i.duplicate()
				i.clear()
				set_scale(new_s)
				set_global_rotation(new_r)
				# Set debug
				debug += "Rotated."
		else:
			# Set debug
			debug += "No Controller Found."
	else:
		# Set debug
		debug += "No Target Found."
	# Check if process debugger
	if PROCESS_DEBUGGER == true and debug != "Gizmo Process: ":
		_debugger(debug)

# Should only be called by self
func _setup_target(tar: Node3D = target, col: bool = collides) -> void:
	# Set debug
	var debug = "Gizmo Setup, Target: " +str(tar)
	# Check if target exist
	if tar != null:
		# Reset colours
		_reset_colours()
		# Set as always visible
		_set_always_visible()
		# Check if rigid body
		if tar is RigidBody3D:
			# Disable gravity
			tar.set_gravity_scale(0.0)
			# Set debug
			debug += ". Gravity Disabled"
		# Check if can collide
		if col == false:
			# Find collision nodes
			for child in tar.get_children():
				if child is CollisionShape3D or child is CollisionPolygon3D:
					# Disable collision
					child.set_disabled(true)
			# Set debug
			debug += ". Disabled Target Collision."
		else:
			# Set debug
			debug += ". Target Has Collision."
	else:
		# Set debug
		debug += ". No Target Found."
	# Set old target
	old_target = target
	old_collides = collides
	_debugger(debug)

# Should only be called by self
func _reset_target(tar: Node3D = target, col: bool = collides) -> void:
	# Set debug
	var debug = "Gizmo Reset Target: " +str(tar)
	# Check if target exist
	if tar != null:
		# Check if rigid body
		if tar is RigidBody3D:
			# Enable gravity
			tar.set_gravity_scale(1.0)
			# Wake up
			tar.set_sleeping(false)
			# Set debug
			debug += ". Gravity Enabled"
		# Check if can collide
		if col == false:
			# Find collision nodes
			for child in tar.get_children():
				if child is CollisionShape3D or child is CollisionPolygon3D:
					# Disable collision
					child.set_disabled(false)
			# Set debug
			debug += ". Reset Target Collision."
		else:
			# Set debug
			debug += ". Target Has Collision."
	else:
		# Set debug
		debug += ". No Target Found."
	_debugger(debug)

# Should only be called by self
func _reset_colours() -> void:
	# Set debug
	var debug = "Gizmo: Reset Colours."
	# Set var
	var mat
	# Set colours
	mat = center.get_surface_override_material(0)
	mat.albedo_color = colours[3]
	mat.albedo_color.a = alpha
	mat = x_arm.get_surface_override_material(0)
	mat.albedo_color = colours[0]
	mat.albedo_color.a = alpha
	mat = x_arrow.get_surface_override_material(0)
	mat.albedo_color = colours[0]
	mat.albedo_color.a = alpha
	mat = y_arm.get_surface_override_material(0)
	mat.albedo_color = colours[1]
	mat.albedo_color.a = alpha
	mat = y_arrow.get_surface_override_material(0)
	mat.albedo_color = colours[1]
	mat.albedo_color.a = alpha
	mat = z_arm.get_surface_override_material(0)
	mat.albedo_color = colours[2]
	mat.albedo_color.a = alpha
	mat = z_arrow.get_surface_override_material(0)
	mat.albedo_color = colours[2]
	mat.albedo_color.a = alpha
	mat = x_ring.get_surface_override_material(0)
	mat.albedo_color = colours[0]
	mat.albedo_color.a = alpha
	mat = y_ring.get_surface_override_material(0)
	mat.albedo_color = colours[1]
	mat.albedo_color.a = alpha
	mat = z_ring.get_surface_override_material(0)
	mat.albedo_color = colours[2]
	mat.albedo_color.a = alpha
	mat = x_cube.get_surface_override_material(0)
	mat.albedo_color = colours[0]
	mat.albedo_color.a = alpha
	mat = y_cube.get_surface_override_material(0)
	mat.albedo_color = colours[1]
	mat.albedo_color.a = alpha
	mat = z_cube.get_surface_override_material(0)
	mat.albedo_color = colours[2]
	mat.albedo_color.a = alpha
	mat = xy_x_piece.get_surface_override_material(0)
	mat.albedo_color = colours[0]
	mat.albedo_color.a = alpha
	mat = xy_y_piece.get_surface_override_material(0)
	mat.albedo_color = colours[1]
	mat.albedo_color.a = alpha
	mat = yz_y_piece.get_surface_override_material(0)
	mat.albedo_color = colours[1]
	mat.albedo_color.a = alpha
	mat = yz_z_piece.get_surface_override_material(0)
	mat.albedo_color = colours[2]
	mat.albedo_color.a = alpha
	mat = zx_z_piece.get_surface_override_material(0)
	mat.albedo_color = colours[2]
	mat.albedo_color.a = alpha
	mat = zx_x_piece.get_surface_override_material(0)
	mat.albedo_color = colours[0]
	mat.albedo_color.a = alpha
	_debugger(debug)

# Should only be called by self
func _set_always_visible() -> void:
	# Set debug
	var debug = "Gizmo: Set Always Visible."
	# Set var
	var mat
	var draw
	var vis = always_visible
	# Check if always visible
	if vis == true:
		# Set draw mode
		draw = BaseMaterial3D.DEPTH_DRAW_ALWAYS
	else:
		# Set draw mode
		draw = BaseMaterial3D.DEPTH_DRAW_OPAQUE_ONLY
	# Set colours
	mat = center.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = x_arm.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = x_arrow.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = y_arm.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = y_arrow.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = z_arm.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = z_arrow.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = x_ring.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = y_ring.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = z_ring.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = x_cube.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = y_cube.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = z_cube.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = xy_x_piece.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = xy_y_piece.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = yz_y_piece.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = yz_z_piece.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = zx_z_piece.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	mat = zx_x_piece.get_surface_override_material(0)
	mat.depth_draw_mode = draw
	mat.no_depth_test = vis
	_debugger(debug)

# Should only be called by self
func _reset_position() -> void:
	# Rest positon
	set_global_position(target.get_global_position() + offset)

# Should only be called by self
func _check_moving() -> bool:
	# Set var
	var moving = false
	# Check if moving
	for a in axis:
		# Check if set
		if moving == false:
			# Set
			moving = a
	return moving

# Should only be called by self
func _debugger(debug_message: String) -> void:
	# Check if script is debug
	if DEBUGGER == true:
		# Check if os debug on
		if OS.is_debug_build():
			# Print message
			print_debug(debug_message)
