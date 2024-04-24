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

var closing_code := """
# Don't touch this, it's necessary to install and load the theme
func _notification(what):
	if what == NOTIFICATION_PARENTED:
		get_parent().emit_signal("new_theme_loaded", id)
"""

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

func rescan_files():
	# Scan the file system - IS THIS WORKING?
	var ep = EditorPlugin.new()
	var fs = ep.get_editor_interface().get_resource_filesystem()
	if not fs.is_scanning():
		fs.scan()

func create_new_theme():
	var theme_id = slugify_string(wiz_theme_name + " " + wiz_theme_author, "-")
	var theme_folder_name = slugify_string(wiz_theme_name, "-")
	var theme_pack_name = slugify_string(wiz_theme_name + " pack", "-")
	var theme_folder_path = "res://themes/" + theme_folder_name
	var starter_template_path: String
	
	print("theme_id: " + theme_id + "| theme_folder_name: " + theme_folder_name + "| theme_pack_name: " + theme_pack_name + "| theme_type: " + wiz_theme_type as String)
	
	if wiz_theme_type == 0:
		starter_template_path = light_theme_starter_path
	
	create_folders_and_files(theme_folder_name, starter_template_path)
	var new_script = create_theme_script(wiz_theme_name, wiz_theme_author, wiz_theme_version, theme_id, theme_folder_name, theme_pack_name, starter_template_path)
	create_theme_scene(theme_folder_path, theme_id, starter_template_path, new_script)
	
	rescan_files()
	

func create_folders_and_files(theme_folder_name, starter_template_path):
	var theme_folder_path = "res://themes/" + theme_folder_name	
	var dir = Directory.new()
	
	# Make the theme folders
	var err = dir.make_dir_recursive(theme_folder_path + "/assets")
	
	# Copy over the scene and script
	# err = dir.copy(starter_template_path + "/theme.tscn", theme_folder_path + "/theme.tscn")
	#err = dir.copy(starter_template_path + "/theme-name-here.gd", theme_folder_path + "/" + theme_folder_name + ".gd")
	
	# Copy main asset folder
	copy_asset_folder_contents(starter_template_path + "/assets/", theme_folder_path + "/assets/")
	
	# Add the emoji folder and contents if the option was checked
	if err == OK && wiz_theme_custom_emoji == true:
		err = dir.make_dir(theme_folder_path + "/assets/emoji/")
		# Copy over contents
		copy_asset_folder_contents(starter_template_path + "/assets/emoji/", theme_folder_path + "/assets/emoji/")
		
	# Scan the file system - IS THIS WORKING?
	rescan_files()
	

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

func create_theme_scene(theme_folder_path, theme_id, starter_template_path, new_script):
	var starter_theme_scene = load(starter_template_path + "/theme.tscn")
	var working_theme_scene = starter_theme_scene.instance()
	var packed_scene = PackedScene.new()
	
	working_theme_scene.name = theme_id
	working_theme_scene.set_script(new_script)
	print(working_theme_scene)
	
#	var off_icon_image = Image.new()
#	print("Attempting to load: " + theme_folder_path + "/assets/light_toggle_off.png")
#	off_icon_image.load(theme_folder_path + "/assets/light_toggle_off.png")
#	print(off_icon_image)
#	var off_icon_image_texture = ImageTexture.new()
#	var off_icon_stream_texture = StreamTexture.new()
#	off_icon_stream_texture.load(theme_folder_path + "/assets/light_toggle_off.png")
#	off_icon_image_texture.create_from_image(off_icon_image)
#	working_theme_scene.get_node("CheckButtonOverride").add_icon_override("off", off_icon_stream_texture)
	
	var result = packed_scene.pack(working_theme_scene)
	
	if result == OK:
		ResourceSaver.save(theme_folder_path + "/theme.tscn", packed_scene)
		

func create_theme_script(theme_name, theme_author, theme_version, theme_id, theme_folder_name, pack_name, starter_template_path):
	var theme_folder_path = "res://themes/" + theme_folder_name
	var main_code_path = starter_template_path + "/theme-name-here.gd"
	var optional_code_path = starter_template_path + "/optional-params.gd"
	
	var f=File.new()
	f.open(main_code_path, File.READ)
	
	var new_script = GDScript.new()
	var new_source_code = f.get_as_text()
	
	new_source_code = new_source_code.format([theme_name, theme_author, theme_version, theme_id, theme_folder_name, pack_name]) + closing_code
	
	new_script.source_code = new_source_code
	new_script.resource_path = theme_folder_path + "/" + theme_folder_name + ".gd"
	ResourceSaver.save(new_script.resource_path, new_script)
	new_script.reload()
	f.close()
	
	return new_script
