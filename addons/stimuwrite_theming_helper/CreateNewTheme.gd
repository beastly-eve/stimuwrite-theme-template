tool
extends Button

func _ready():
	pass

func _on_CreateNewTheme_pressed():
	var theme_name = get_parent().get_node("ThemeName").text
	var theme_author = get_parent().get_node("ThemeAuthor").text
	var theme_version = get_parent().get_node("ThemeVersion").text
	
	if theme_name && theme_author && theme_version:
		print("You filled everything out, good job")
		ThemingHelper.wiz_theme_name = theme_name
		ThemingHelper.wiz_theme_author = theme_author
		ThemingHelper.wiz_theme_version = theme_version
		ThemingHelper.wiz_theme_type = get_parent().get_node("StartingTypeDropdown").selected
		ThemingHelper.wiz_theme_custom_emoji = get_parent().get_node("CustomEmoji").pressed as bool
		ThemingHelper.wiz_theme_custom_bg = get_parent().get_node("CustomBackground").pressed as bool
		get_parent().get_node("ErrorTextPanel").visible = false
		print(ThemingHelper.wiz_theme_custom_emoji)
		print(ThemingHelper.wiz_theme_custom_bg)
		ThemingHelper.create_new_theme()
	else:
		get_parent().get_node("ConfirmationTextPanel").visible = false
		get_parent().get_node("ErrorTextPanel").visible = true
