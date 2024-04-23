tool
extends EditorPlugin

const ThemingDialogScene := preload("res://addons/stimuwrite_theming_helper/theming-dialog.tscn") 

var themingtools_dock
var themingtools_confirmation: ConfirmationDialog

func _enter_tree():
	themingtools_dock = preload("res://addons/stimuwrite_theming_helper/helper-dock.tscn").instance()
	# Add the loaded scene to the docks
	add_control_to_dock(DOCK_SLOT_LEFT_UL, themingtools_dock)
	
	themingtools_confirmation = ThemingDialogScene.instance()
	get_editor_interface().add_child(themingtools_confirmation)
	add_autoload_singleton("ThemingHelper", "res://addons/stimuwrite_theming_helper/theming-helper.gd")

func _exit_tree():
	# Remove the dock.
	remove_control_from_docks(themingtools_dock)
	# Erase the control from the memory.
	themingtools_dock.free()
	
	if themingtools_confirmation:
		themingtools_confirmation.queue_free()
	
	remove_autoload_singleton("ThemingHelper")
		
		
