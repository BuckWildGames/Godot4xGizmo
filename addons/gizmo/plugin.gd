@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type("GizmoReceiver", "Node3D", preload("receiver.gd"),null)
	add_custom_type("GizmoController", "Node3D", preload("controller.gd"),null)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
