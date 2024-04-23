extends Control

export(String) var theme_name = "Your Theme Name Here" # the human readable name of your theme that will be shown in the dropdown
export(String) var theme_author = "Author Name Here"   
export(String) var theme_version = "1.0" 
export(String) var id = "theme-id-here" # Theme ID must match the root node name in theme.tscn, use a combination of author name and theme name. So a Speed Metal theme by Heavy Dude would have an id of heavy-dude-speed-metal
export(String) var folder_name = "theme-name-here" # Replace with your alpha-numeric theme name, use dashes instead of space (kebab case)
export(String) var pack = "theme-pack-name-here" # If you export multiple themes together they must share a pack name, include a pack name even if your theme is solo
export(bool) var enabled = false # Leave this

# OPTIONAL PARAMETERS - remove these if you are not using them

# Video background
# Video backgrounds must be an in the OGV file format and be accompanied by a jpg screen capture of the first frame of the video with the same name. IF YOU ARE NOT USING A CUSTOM BACKGROUND, DELETE THESE.
export(bool) var theme_background = true # Change this to false if your theme has no video background
export(String) var theme_background_location = "res://themes/theme-name-here/assets/background" # Use the file path of your background, this will point to both the OGV and JPG, so do not include a file extension.

# Theme emoji
# Include the paths to your theme emoji here, the images included in this  example are identical to the default
export(bool) var theme_emoji = false # Change this to true if you want to use custom emoji
export(String) var theme_main_emoji_location = "res://themes/theme-name-here/assets/emoji/main-emoji.png" # Update these paths to match your custom emoji file names, if you are using custom emoji, all of these are required
export(String) var theme_thumb_emoji_location = "res://themes/theme-name-here/assets/emoji/thumb-emoji.png"
export(String) var theme_clapping_emoji_location = "res://themes/theme-name-here/assets/emoji/clapping.png"
export(String) var theme_smile_emoji_location = "res://themes/theme-name-here/assets/emoji/smile-emoji.png"
export(String) var theme_exploding_emoji_location = "res://themes/theme-name-here/assets/emoji/exploding.png"
export(String) var theme_party1_emoji_location = "res://themes/theme-name-here/assets/emoji/party1-emoji.png"
export(String) var theme_party2_emoji_location = "res://themes/theme-name-here/assets/emoji/party2-emoji.png"

# Don't touch this, it's necessary to install and load the theme
func _notification(what):
	if what == NOTIFICATION_PARENTED:
		get_parent().emit_signal("new_theme_loaded", id)
