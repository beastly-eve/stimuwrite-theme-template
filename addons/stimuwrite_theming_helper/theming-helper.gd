tool
extends Node

signal _create_new_theme_pressed(name, author, version)

const light_theme_starter_path = "res://addons/stimuwrite_theming_helper/light-theme-starter-files"
const dark_theme_starter_path = ""

var wiz_theme_name: String
var wiz_theme_author: String
var wiz_theme_version: String
var wiz_theme_type:= 0
var wiz_theme_custom_emoji:= false
var wiz_theme_custom_bg:= false

func slugify_string(string: String, seperator: String):
	var allow_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", seperator]
	var output:= ""
	
	string = string.to_lower()
	string = string.replace(" ", seperator)
	
	for position in string.length():
		var current_character := string[position]
		if allow_list.has(current_character):
			output += current_character
	output = output.rstrip("-")
	output = output.replace("--", "-")
	return output
	

func create_new_theme():
	var theme_id = slugify_string(wiz_theme_name + " " + wiz_theme_author, "-")
	var theme_folder_name = slugify_string(wiz_theme_name, "-")
	var theme_pack_name = slugify_string(wiz_theme_name + " pack", "-")
	
	print("theme_id: " + theme_id + "| theme_folder_name: " + theme_folder_name + "| theme_pack_name: " + theme_pack_name + "| theme_type: " + wiz_theme_type as String)
	
	create_folders_and_files(theme_folder_name, wiz_theme_type)
	

func create_folders_and_files(theme_folder_name, theme_type):
	var starter_template_path: String
	var theme_folder_path = "res://themes/" + theme_folder_name
	
	if theme_type == 0:
		starter_template_path = light_theme_starter_path
		
	var dir = Directory.new()
	
	# Make the theme folders
	var err = dir.make_dir_recursive(theme_folder_path + "/assets")
	
	# Copy over the scene and script
	err = dir.copy(starter_template_path + "/theme.tscn", theme_folder_path + "/theme.tscn")
	err = dir.copy(starter_template_path + "/theme-name-here.gd", theme_folder_path + "/" + theme_folder_name + ".gd")
	
	# Copy main asset folder
	copy_asset_folder_contents(starter_template_path + "/assets/", theme_folder_path + "/assets/")
	
	# Add the emoji folder and contents if the option was checked
	if err == OK && wiz_theme_custom_emoji == true:
		err = dir.make_dir(theme_folder_path + "/assets/emoji/")
		copy_asset_folder_contents(starter_template_path + "/assets/emoji/", theme_folder_path + "/assets/emoji/")
	

func copy_asset_folder_contents(starter_asset_folder_path, theme_asset_folder_path):
	var dir = Directory.new()
	# Copy assets
	if dir.open(starter_asset_folder_path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.get_extension() != "import" && not file_name == "background.jpg" && not file_name == "background.ogv" && not wiz_theme_custom_bg:
					dir.copy(starter_asset_folder_path + file_name, theme_asset_folder_path + file_name)
				elif file_name.get_extension() != "import" && wiz_theme_custom_bg:
					dir.copy(starter_asset_folder_path + file_name, theme_asset_folder_path + file_name)
				
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")	
