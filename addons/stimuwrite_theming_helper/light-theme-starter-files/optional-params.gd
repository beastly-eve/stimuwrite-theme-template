# OPTIONAL PARAMETERS - remove these if you are not using them

# Video background
# Video backgrounds must be an in the OGV file format and be accompanied by a jpg screen capture of the first frame of the video with the same name. IF YOU ARE NOT USING A CUSTOM BACKGROUND, DELETE THESE.
export(bool) var theme_background = true # Change this to false if your theme has no video background
export(String) var theme_background_location = "res://themes/{4}/assets/background" # Use the file path of your background, this will point to both the OGV and JPG, so do not include a file extension.

# Theme emoji
# Include the paths to your theme emoji here, the images included in this  example are identical to the default
export(bool) var theme_emoji = true # Change this to true if you want to use custom emoji
export(String) var theme_main_emoji_location = "res://themes/{4}/assets/emoji/main-emoji.png" # Update these paths to match your custom emoji file names, if you are using custom emoji, all of these are required
export(String) var theme_thumb_emoji_location = "res://themes/{4}/assets/emoji/thumb-emoji.png"
export(String) var theme_clapping_emoji_location = "res://themes/{4}/assets/emoji/clapping-emoji.png"
export(String) var theme_smile_emoji_location = "res://themes/{4}/assets/emoji/smiling-emoji.png"
export(String) var theme_exploding_emoji_location = "res://themes/{4}/assets/emoji/exploding-emoji.png"
export(String) var theme_party1_emoji_location = "res://themes/{4}/assets/emoji/party1-emoji.png"
export(String) var theme_party2_emoji_location = "res://themes/{4}/assets/emoji/party2-emoji.png"
