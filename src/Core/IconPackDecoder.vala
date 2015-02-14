/*-
 *  Copyright (c) 2015 George Sofianos
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  Authored by: George Sofianos <georgesofianosgr@gmail.com>
 */

using Gee;

public class IconInstaller.Core.IconPackDecoder {

    public File working_file;
    public signal void decode_finished (Models.IconPack icon_pack);
    // sizes based on this page http://www.visualpharm.com/articles/icon_sizes.html

    public IconPackDecoder () {

    }

    public void decode (string path) {

        working_file = File.new_for_path (path);
        if ( !working_file.query_exists () )
            return; // TODO throw error
        
        if (Core.FileSystem.is_file (path)) {
            var type = working_file.query_info ("standard::*",FileQueryInfoFlags.NONE).get_content_type ();
            if (type == "image/x-icns") {
                var icon_pack = create_icon_pack_for_icns_file ();
                decode_finished (icon_pack);
            }

            // TODO add code for icon
            
        } else {
            stdout.printf ("Path is a folder\n");
            if (is_folder_categorized ()) {
                stdout.printf ("Path is categorized\n");
                // TODO check for errors retrieve icon pack name
                var icon_pack = create_icon_pack_for_categorized_folder ();
                decode_finished (icon_pack);
            } else {
                // maybe folder is not categorized TODO
            }
        }
        // Check if path is file or folder
        // Load working files
        // get_categorized_folder_icons / get uncategorized_folder_icons / get_icon_file_icons / get_icns_file_icons
    }

    private bool is_folder_categorized () {
        var directories = FileSystem.get_directories (working_file.get_path ());

        foreach (File directory in directories) {
            foreach (int size in App.supported_icon_sizes) {
                var category_name = convert_size_to_folder_name (size);
                if (directory.get_basename() == category_name)
                    return true;
            }
        }

        return false;
        // TODO : Fix problem, on large given paths this will freeze (needs also cancel)
    }

    private Models.IconPack create_icon_pack_for_icns_file () {
        string icon_pack_name = "";
        var icons_list = get_icns_file_icons ();
        if (icons_list.size > 0)
            icon_pack_name = icons_list[0].name;

        return new Models.IconPack.with_list_and_name (icons_list,icon_pack_name);
    }

    private ArrayList<Models.Icon>? get_icns_file_icons () {
        string temp_path = Environment.get_tmp_dir ();
        var icon_installer_tmp_dir = File.new_for_path (temp_path);
        icon_installer_tmp_dir = icon_installer_tmp_dir.get_child (App.instance.application_id);

        if (icon_installer_tmp_dir.query_exists()) {
            App.empty_tmp_dir ();
        } 
        
        icon_installer_tmp_dir.make_directory ();

        // TODO copy icns to directory renamed to temp.icns (to prevent numbers in file name)
        string command = @"icns2png -x -d 32 '$(working_file.get_path())' -o '$(icon_installer_tmp_dir.get_path())'";
        var result = Posix.system (command);
        if (result != 0) {
            debug ("icns2png command exited with code: " + @"$result" + "\n");
            return null;
        }

        var files_list = Core.FileSystem.get_files (icon_installer_tmp_dir.get_path ());
        var icons_list = new ArrayList <Models.Icon> ();

        foreach (File file in files_list) {
            var file_name = file.get_basename ().replace ("x32"," ");
            foreach (int size in App.supported_icon_sizes) {
                if (file_name.contains(@"$size")) {
                    var icon = new Models.Icon ();
                    icon.path = file.get_path ();
                    icon.size = size;
                    icon.name = Core.FileSystem.get_file_name_without_ext (working_file);
                    icons_list.add (icon);
                    break;
                }
            }
        }

        return icons_list;
    }

    private Models.IconPack create_icon_pack_for_categorized_folder () {
        string icon_pack_name = "";
        var icons_list = get_categorized_folder_icons ();
        if (icons_list.size > 0)
            icon_pack_name = icons_list[0].name;

        return new Models.IconPack.with_list_and_name (icons_list,icon_pack_name);
    }

    private ArrayList<Models.Icon> get_categorized_folder_icons () {
        var icon_list = new ArrayList<Models.Icon> ();

        foreach (int size in App.supported_icon_sizes) {
            Models.Icon? icon = get_categorized_folder_icon (size);
            
            if (icon != null)
                icon_list.add (icon);
        }

        return icon_list;
    }

    // Returns an icon from pixels path (ex 32x32)
    private Models.Icon? get_categorized_folder_icon (int size) {
        var folder_name = convert_size_to_folder_name (size);
        var directory = working_file.get_child(folder_name);

        if (!directory.query_exists()) {
            debug ("Folder category " + folder_name + " doesn't exist\n");
            return null;
        }

        var files_list = FileSystem.get_files (directory.get_path());
        if (files_list.size != 1) {
            warning("Found more than 1 file in categorized folder " + folder_name + " .Will not include the icon\n");
            return null;
            // TODO warn user
        }

        var icon_file = files_list[0];

        // Remove name extension
        var file_name = Core.FileSystem.get_file_name_without_ext (icon_file);

        var icon = new Models.Icon ();
        icon.path = icon_file.get_path ();
        icon.name = file_name;
        icon.size = size;
        return icon;
    }

    private string convert_size_to_folder_name (int size) {
        string folder_name = @"$(size)x$(size)";
        return folder_name;
    }
}