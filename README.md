# StimuWrite Theme Template

Use this template to make your own [StimuWrite](https://eveharms.itch.io/stimuwrite) themes! While I did dream that others would make their own themes for StimuWrite some day, the theming system wasn't exactly made with that in mind. My hope is that this template will make creating a theme for StimuWrite relatively simple for people who are willing to become comfortable with UI override in Godot. Currently, StimuWrite and it's themes are created using Godot Engine 3.5.3 

StimuWrite does not "officially" support distributed third party themes due to liability reasons, so this template is only endorsed for personal use. If you want to  work together to distribute your theme officially, feel free to reach out.

This template and documentation are a work in progress so please bear with me and feel free to contribute. There is little error reporting for theming built into StimuWrite, so feel free to reach out to me if you are stuck. Make sure to follow the directions carefully because there are a few things that are required or your theme will silently fail.

## Using the Theme Wizard for Setup (new! easy!)

Included in the template is now a Godot plugin that makes it easy to setup your new theme! The plugin appears in the left sidebar, but can be disabled after setup in Project > Project Settings > Plugins. Simply fill in your theme info and options and the wizard will setup your theme up in the correct manner for StimuWrite to read it.

Using the wizard will skip the **Manual Template and file setup** and **Theme config script setup** steps and get straight to Editing your theme! 

## Manual template and file setup

1. Download the files and duplicate the root folder
2. Rename the folder to your theme name using [kebab case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case) and open it in [Godot Engine 3.5.3](https://godotengine.org/download/3.x/)
3. When you rename other files and folders, make sure to do it in the Godot editor and not your file system
4. In the open project you will find the following files and folders
   1. `themes` - The parent themes folder that mirrors the StimuWrite file system. **Do not change the name of this folder** or your theme will break
   2. `themes/theme-name-here` - **Change the name of this subfolder to your theme name in kebab case**, make sure your theme name is unique so it doesn't conflict with other themes. This is where your theme will live. (You can also duplicate this folder and create multiple themes in one Godot project to export as a theme pack)
   3. `themes/assets` -  Where all of the images and videos for your theme will live. You can change this folder name and organize your assets how you like, as long as your references are correct in your Godot project and config file. Sample files have been included in the template, use these as is or as guides to create your own
   4. `theme-name-here.gd` - This is the config script file that sets the attributes for your theme and defines optional custom backgrounds and emojis. **Rename this file to your theme name in kebab case**
   5. `theme.tscn` - This is the scene file that contains your theme. You will be editing the elements in it in the Godot UI and StimuWrite will use them as models to update its UI to match. **Do not change the name of this file**.
   6. `vreq1_9.tres` - This resource file tells StimuWrite the minimum version required to open the theme. **Do not change the name of this file**. In the future it may be updated if more features are added to themes.
5. In Godot **go to Project > Settings and change the name to your theme** name or theme pack name or simply "Theme dev". This will ensure it will display in the Godot project selection on launch.

## Theme config script setup

The gdscript included with the template is where you define the export variables and paths so StimuWrite knows how to load your theme. 

Start by replacing the placeholder values in the theme with your own. Do this in the Godot code editor rather than the inspector.

### Required Values

1. `theme_name` - This is the human readable name of your theme that will be shown in the dropdown
2. `theme_author` - Put your name here!
3. `theme_version` - In the future StimuWrite may support upgrading themes, but at the moment this is not really a functional field. Include a version number anyway
4. `id` - The theme ID must match the root node name in theme.tscn, use a combination of author name and theme name to make sure it's unique. So a Speed Metal theme by Heavy Dude would have an id of heavy-dude-speed-metal. **Change the root node's name in theme.tscn scene to this id, it won't work if you don't do this**
5. `folder_name` - Change this to the folder name of your theme that you defined in the file setup step
6. `pack` - You can export multiple themes together to make a pack. If you do this they must share a pack name. But include a unique pack name even if your theme is solo. Use kebab case
7. `enabled` - Don't touch this

### Optional parameters

Currently you can add a custom video background to themes and custom default emoji. You can delete these lines of code if you don't intend on using these features. 

#### Video background

The video format StimuWrite uses is the Ogg Vorbis Video format with the extension of OGV. There are free file converting websites online that can convert your video to OGV, but they generally use the extension of OGG. To remedy this, simply rename the file extension of your converted video from OGG to OGV.  Take a JPG screenshot of the first frame of your video at the same resolution, give it the same name, and put them in the same assets folder. I use VLC to play and take snapshots of my OGV videos.

1. Make sure you have your OGV and JPG background files, that share the same name with the requirements described above, in your assets folder
2. `theme_background` - This must be set to true to enable the feature
3. `theme_background_location` - Use the file path of your background, this will point to both the OGV and JPG, so **do not include a file extension**. Make sure the file paths are updated to match the changed folder names
4. **If you are not using a video background, delete this code**

#### Custom Emoji

You can override the default emoji for you theme by setting `theme_emoji` to true and updating the values below it. The default emoji used by StimuWrite are included in the template. All values included are required if you are using custom emoji. Make sure the file paths are updated to match the changed folder names.

## Editing your theme

You are now ready to make modifications to the theme element nodes and create your theme! Open the theme.tscn file and get started modifying the supplies Control nodes. These changes are made using Godot's built in UI and CanvasItem features.

#### Helpful Info

- Customizing these Control nodes takes place in the Inspector panel that appears on the right side of the screen when you click on one. 
- Most of the changes are made in the **Theme Overrides** section. Expand the subsections here to see what has been overridden already to figure out what you can change.
- Some elements are also defined in the **Theme** section, such as scrollbars.
- In general, you will see what you can change by if it is already "overridden" in the inspector. Not everything that can be changed in the Godot UI will be respected by StimuWrite.
- Everything takes place in the styleboxes and options in the template nodes. Any new nodes you add will be ignored.
- To add images to the elements, use StyleBoxTexture
- You can also change CanvasItem > Visibility > Modulate for color tinting
- CanvasItem > Material can be updated as well. This gives you the option of using [Shaders](https://godotshaders.com/shader-type/canvas_item/) 🤯
- Click the reset circular arrow icon to start fresh on elements you want to style
- Detailed documentation of Godot's GUI skinning can be found here https://docs.godotengine.org/en/3.5/tutorials/ui/gui_skinning.html
- Changing fonts is currently not supported
- Do not delete any nodes except for BackPanelOverride, that is the only optional node included in the template
- **Not working?** Did you remember to change the root node of this scene to your theme id? Does your folder's name match with the folder_name variable? 

## Exporting your theme

1. In the Godot menu go to Project > Export
2. Select the included Theme Export export template
3. Click the "Resources" tab and make sure all of your files are selected to be exported
4. Don't change any other settings
5. Click the "Export PCK/Zip..."  button
6. Save your theme file with the extension .pck or .stimtheme (there's no actual difference)

## Testing your theme

To test, load your theme file into StimuWrite like any other theme. Unfortunately, there is currently no way to "update themes" so to see a newly exported version you will have to go to Advanced Settings and press the scary DELETE ALL button to clear out all settings and add-ons. Make sure you keep copies of any themes you have in a separate folder.

It's possible that you may break StimuWrite or it will give you an error when trying to install your theme. If that happens and the DELETE ALL button doesn't do the trick, close StimuWrite and go to the user folder in your file system and delete `stimuwrite.cfg` and the `addons` folder. You can find them here: 

Windows `%APPDATA%\Godot\app_userdata\StimuWrite\`  
macOS: `~/Library/Application Support/Godot/app_userdata/StimuWrite/` 
Linux: `~/.local/share/godot/app_userdata/StimuWrite/`

Happy theming! 