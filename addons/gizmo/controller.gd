extends Node3D
class_name GizmoController
## Controller node for gizmo addon. Add as child of main camera.
# (Works best with a "free cam")

# !!
# Do not edit unless you are prepared for bugs.
# Only edit settings using the inspector.
# Settings for both controller and receiver.
# !!

const DEBUGGER: bool = false

const GIZMO: = preload("res://addons/gizmo/gizmo.tscn")

@export_group("Customize Gizmo")
## Any custom gizmo must be set up as the default gizmo scene but with custom mesh and collision.
@export var custom_gizmo: PackedScene
## Sets the alpha for the gizmo.
@export var gizmo_alpha: float = 0.7
## Sets the use of custom colours.
@export var custom_colours: bool = false
@export_subgroup("Colours")
## Sets the x axis colour.
@export_color_no_alpha var gizmo_x_colour: Color = Color.RED
## Sets the y axis colour.
@export_color_no_alpha var gizmo_y_colour: Color = Color.GREEN
## Sets the z axis colour.
@export_color_no_alpha var gizmo_z_colour: Color = Color.BLUE
## Sets the selected colour.
@export_color_no_alpha var gizmo_selected_colour: Color = Color.YELLOW

@export_group("Enable Gizmo")
## Enables the whole gizmo.
@export var gizmo_enabled: bool = true
## Enables the gizmo center.
@export var gizmo_center: bool = false
## Enables the gizmo positions.
@export var gizmo_position: bool = true
## Enables the gizmo rotations.
@export var gizmo_rotation: bool = true
## Enables the gizmo scales.
@export var gizmo_scale: bool = true
## Enables the gizmo multi positions.
@export var gizmo_multi_position: bool = true

@export_group("Setup Gizmo")
## Sets default whether target collides.
@export var gizmo_target_collides: bool = false
## Sets default gizmo offset.
@export var gizmo_offset: Vector3 = Vector3.ZERO
## Sets whether gizmo will always be visible, even through other objects. (Gizmo will not receive inputs through objects if target_collides is true)
@export var gizmo_always_visible: bool = true
## Sets whether gizmo will always update its position or only after input released.
@export var gizmo_always_update: bool = false
## Sets multiplier for sizing with camera distance.
@export var gizmo_scale_multiplier: float = 0.5
## Sets the step size when moving a target.
@export var gizmo_step: float = 5.0

var gizmo: Node3D = null
var gizmo_colours: Array = [gizmo_x_colour,gizmo_y_colour,gizmo_z_colour,gizmo_selected_colour]

# Can be called directly or connected to a signal
func clear_gizmo() -> void:
	# Set debug
	var debug = "GizmoController: Clear Gizmo: "
	# Check if gizmo exists
	if gizmo != null:
		# Destroy gizmo
		gizmo.call_deferred("queue_free")
		gizmo = null
		# Set debug
		debug += "Done."
	else:
		# Set debug
		debug += "No Gizmo."

# Should only be called by receiver (use call_create_gizmo)
func create_gizmo(target: Node3D = null, can_move: Vector3 = Vector3.ONE, can_rotate: Vector3 = Vector3.ONE, can_scale: Vector3 = Vector3.ONE, can_multi_move: Vector3 = Vector3.ONE, target_collides: bool = gizmo_target_collides, offset: Vector3 = gizmo_offset) -> void:
	# Set debug
	var debug = "GizmoController: Create Gizmo: "
	# Check if enabled
	if gizmo_enabled == true:
		# Check if gizmo exists
		if gizmo == null:
			# Check if target exists
			if target != null:
				# Create var
				var i 
				# Check if custom gizmo set
				if custom_gizmo != null:
					# Create gizmo
					i = custom_gizmo.instantiate()
				else:
					# Create gizmo
					i = GIZMO.instantiate()
				# Set gizmo
				# Check if custom colours
				if custom_colours == true:
					# Set custom colours
					gizmo_colours = [gizmo_x_colour,gizmo_y_colour,gizmo_z_colour,gizmo_selected_colour]
					i.colours = gizmo_colours
				i.target = target
				i.controller = self
				i.collides = target_collides
				i.always_update = gizmo_always_update
				i.always_visible = gizmo_always_visible
				i.offset = offset
				i.scale_multiplier = gizmo_scale_multiplier
				i.alpha = gizmo_alpha
				i.step = gizmo_step
				_set_visibility(i,can_move,can_rotate,can_scale,can_multi_move)
				# Add child to target
				target.add_child(i)
				var p = target.get_global_position() + offset
				i.set_global_position(p)
				gizmo = i
				# Set debug
				debug += "Complete, Position: " +str(p)
			else:
				# Set debug
				debug += "No Target Found."
		else:
			# Update gizmo
			_update_gizmo(target,can_move,can_rotate,can_scale,can_multi_move,target_collides,offset)
			# Set debug
			debug += "Gizmo Exists, Updating."
	else:
		# Set debug
		debug += "Gizmo Disabled."
	_debugger(debug)

# Should only be called by self (just use receiver call_create_gizmo and it will update instead)
func _update_gizmo(target: Node3D = null, can_move: Vector3 = Vector3.ONE, can_rotate: Vector3 = Vector3.ONE, can_scale: Vector3 = Vector3.ONE, can_multi_move: Vector3 = Vector3.ONE, target_collides: bool = gizmo_target_collides, offset: Vector3 = gizmo_offset) -> void:
	# Set debug
	var debug = "GizmoController: Update Gizmo: "
	# Check if gizmo exist
	if gizmo != null:
		# Set gizmo
		var i = gizmo
		# Check if custom colours
		if custom_colours == true:
			# Set custom colours
			gizmo_colours = [gizmo_x_colour,gizmo_y_colour,gizmo_z_colour,gizmo_selected_colour]
			i.colours = gizmo_colours
		i.target = target
		i.collides = target_collides
		i.always_update = gizmo_always_update
		i.always_visible = gizmo_always_visible
		i.offset = offset
		i.scale_multiplier = gizmo_scale_multiplier
		i.alpha = gizmo_alpha
		i.step = gizmo_step
		_set_visibility(i,can_move,can_rotate,can_scale,can_multi_move)
		var p = target.get_global_position() + offset
		i.set_global_position(p)
		# Set debug
		debug += "Updated."
	else:
		# Set debug
		debug += "No Gizmo Found."
	_debugger(debug)

# Should only be called by self
func _set_visibility(target: Node3D, can_move: Vector3 = Vector3.ONE, can_rotate: Vector3 = Vector3.ONE, can_scale: Vector3 = Vector3.ONE, can_multi_move: Vector3 = Vector3.ONE) -> void:
	# Check center
	if gizmo_center == false:
		# Hide
		target.get_node("Scaler/Center").hide()
	else:
		# Show
		target.get_node("Scaler/Center").show()
	# Check position
	if gizmo_position == false:
		target.get_node("Scaler/Positions").hide()
	else:
		# Show
		target.get_node("Scaler/Positions").show()
		# Check axis
		if can_move.x > 0:
			# Show
			target.get_node("Scaler/Positions/X").show()
		else:
			# Show
			target.get_node("Scaler/Positions/X").hide()
		if can_move.y > 0:
			# Show
			target.get_node("Scaler/Positions/Y").show()
		else:
			# Show
			target.get_node("Scaler/Positions/Y").hide()
		if can_move.z > 0:
			# Show
			target.get_node("Scaler/Positions/Z").show()
		else:
			# Show
			target.get_node("Scaler/Positions/Z").hide()
	# Check rotation
	if gizmo_rotation == false:
		target.get_node("Scaler/Rotations").hide()
	else:
		# Show
		target.get_node("Scaler/Rotations").show()
		# Check axis
		if can_rotate.x > 0:
			# Show
			target.get_node("Scaler/Rotations/X").show()
		else:
			# Show
			target.get_node("Scaler/Rotations/X").hide()
		if can_rotate.y > 0:
			# Show
			target.get_node("Scaler/Rotations/Y").show()
		else:
			# Show
			target.get_node("Scaler/Rotations/Y").hide()
		if can_rotate.z > 0:
			# Show
			target.get_node("Scaler/Rotations/Z").show()
		else:
			# Show
			target.get_node("Scaler/Rotations/Z").hide()
	# Check scale
	if gizmo_scale == false:
		target.get_node("Scaler/Scales").hide()
	else:
		# Show
		target.get_node("Scaler/Scales").show()
		# Check axis
		if can_scale.x > 0:
			# Show
			target.get_node("Scaler/Scales/X").show()
		else:
			# Show
			target.get_node("Scaler/Scales/X").hide()
		if can_scale.y > 0:
			# Show
			target.get_node("Scaler/Scales/Y").show()
		else:
			# Show
			target.get_node("Scaler/Scales/Y").hide()
		if can_scale.z > 0:
			# Show
			target.get_node("Scaler/Scales/Z").show()
		else:
			# Show
			target.get_node("Scaler/Scales/Z").hide()
	# Check multi
	if gizmo_multi_position == false:
		target.get_node("Scaler/MultiPositions").hide()
	else:
		# Show
		target.get_node("Scaler/MultiPositions").show()
		# Check axis
		if can_multi_move.x > 0:
			# Show
			target.get_node("Scaler/MultiPositions/XY").show()
		else:
			# Show
			target.get_node("Scaler/MultiPositions/XY").hide()
		if can_multi_move.y > 0:
			# Show
			target.get_node("Scaler/MultiPositions/YZ").show()
		else:
			# Show
			target.get_node("Scaler/MultiPositions/YZ").hide()
		if can_multi_move.z > 0:
			# Show
			target.get_node("Scaler/MultiPositions/ZX").show()
		else:
			# Show
			target.get_node("Scaler/MultiPositions/ZX").hide()

# Should only be called by self
func _debugger(debug_message: String) -> void:
	# Check if script is debug
	if DEBUGGER == true:
		# Check if os debug on
		if OS.is_debug_build():
			# Print message
			print_debug(debug_message)
