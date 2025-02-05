extends Node

@onready var gizmo: Node3D = get_parent()

func _on_x_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: X Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.x_arm.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		mat = gizmo.x_arrow.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)


func _on_x_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: X Mouse Exit."
		gizmo._debugger(debug)

func _on_x_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: X Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[0] = true
				gizmo._debugger(debug)

func _on_y_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: Y Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.y_arm.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		mat = gizmo.y_arrow.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_y_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: Y Mouse Exit."
		gizmo._debugger(debug)

func _on_y_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: Y Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[1] = true
				gizmo._debugger(debug)

func _on_z_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: Z Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.z_arm.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		mat = gizmo.z_arrow.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_z_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: Z Mouse Exit."
		gizmo._debugger(debug)

func _on_z_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: Z Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[2] = true
				gizmo._debugger(debug)


func _on_rot_x_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: RotX Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.x_ring.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_rot_x_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: RotX Mouse Exit."
		gizmo._debugger(debug)

func _on_rot_x_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: RotX Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[3] = true
				gizmo._debugger(debug)

func _on_rot_y_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: RotY Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.y_ring.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_rot_y_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: RotY Mouse Exit."
		gizmo._debugger(debug)

func _on_rot_y_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: RotY Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[4] = true
				gizmo._debugger(debug)

func _on_rot_z_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: RotZ Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.z_ring.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_rot_z_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: RotZ Mouse Exit."
		gizmo._debugger(debug)

func _on_rot_z_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: RotZ Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[5] = true
				gizmo._debugger(debug)

func _on_scl_x_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: SclX Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.x_cube.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_scl_x_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: SclX Mouse Exit."
		gizmo._debugger(debug)

func _on_scl_x_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: SclX Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[6] = true
				gizmo._debugger(debug)

func _on_scl_y_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: SclY Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.y_cube.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_scl_y_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: SclY Mouse Exit."
		gizmo._debugger(debug)

func _on_scl_y_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: SclY Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[7] = true
				gizmo._debugger(debug)

func _on_scl_z_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: SclZ Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.z_cube.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_scl_z_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: SclZ Mouse Exit."
		gizmo._debugger(debug)

func _on_scl_z_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: SclZ Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[8] = true
				gizmo._debugger(debug)

func _on_xy_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: XY Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.xy_x_piece.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		mat = gizmo.xy_y_piece.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_xy_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: XY Mouse Exit."
		gizmo._debugger(debug)

func _on_xy_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: XY Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[9] = true
				gizmo._debugger(debug)

func _on_yz_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: YZ Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.yz_y_piece.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		mat = gizmo.yz_z_piece.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_yz_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: YZ Mouse Exit."
		gizmo._debugger(debug)

func _on_yz_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: YZ Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[10] = true
				gizmo._debugger(debug)

func _on_zx_mouse_entered() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Set debug
		var debug = "Gizmo: ZX Mouse Over."
		# Set var
		var mat
		# Set colours
		mat = gizmo.zx_z_piece.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		mat = gizmo.zx_x_piece.get_surface_override_material(0)
		mat.albedo_color = gizmo.colours[3]
		mat.albedo_color.a = gizmo.alpha
		gizmo._debugger(debug)

func _on_zx_mouse_exited() -> void:
	# Check moving
	if gizmo._check_moving() == false:
		# Reset colours
		gizmo._reset_colours()
		# Set debug
		var debug = "Gizmo: ZX Mouse Exit."
		gizmo._debugger(debug)

func _on_zx_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Check event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				# Set debug
				var debug = "Gizmo: ZX Selected."
				# Set position
				gizmo.old_positon = get_viewport().get_mouse_position()
				# Set axis
				gizmo.axis[11] = true
				gizmo._debugger(debug)
