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
		get_parent().get_node("ErrorTextPanel").visible = false
	else:
		get_parent().get_node("ConfirmationTextPanel").visible = false
		get_parent().get_node("ErrorTextPanel").visible = true
