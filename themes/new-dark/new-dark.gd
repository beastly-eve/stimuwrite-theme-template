extends Control

export(String) var theme_name = "New Dark" # the human readable name of your theme that will be shown in the dropdown
export(String) var theme_author = "Dark Guy"   
export(String) var theme_version = "1.0" 
export(String) var id = "new-dark-dark-guy" # Theme ID must match the root node name in theme.tscn, use a combination of author name and theme name. So a Speed Metal theme by Heavy Dude would have an id of heavy-dude-speed-metal
export(String) var folder_name = "new-dark" # Replace with your alpha-numeric theme name, use dashes instead of space (kebab case)
export(String) var pack = "new-dark-pack" # If you export multiple themes together they must share a pack name, include a pack name even if your theme is solo
export(bool) var enabled = false # Leave this


# Don't touch this, it's necessary to install and load the theme
func _notification(what):
	if what == NOTIFICATION_PARENTED:
		get_parent().emit_signal("new_theme_loaded", id)
