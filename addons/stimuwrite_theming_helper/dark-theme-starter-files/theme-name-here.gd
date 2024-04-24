extends Control

export(String) var theme_name = "{0}" # the human readable name of your theme that will be shown in the dropdown
export(String) var theme_author = "{1}"   
export(String) var theme_version = "{2}" 
export(String) var id = "{3}" # Theme ID must match the root node name in theme.tscn, use a combination of author name and theme name. So a Speed Metal theme by Heavy Dude would have an id of heavy-dude-speed-metal
export(String) var folder_name = "{4}" # Replace with your alpha-numeric theme name, use dashes instead of space (kebab case)
export(String) var pack = "{5}" # If you export multiple themes together they must share a pack name, include a pack name even if your theme is solo
export(bool) var enabled = false # Leave this

