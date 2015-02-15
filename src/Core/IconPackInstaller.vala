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

public class IconInstaller.Core.IconPackInstaller {

    public signal void install_finished (bool success);
    private string user_hicolor_path ;

    public IconPackInstaller () {
        user_hicolor_path =  Environment.get_user_data_dir () + "/icons/hicolor";
    }

    public void install (Models.IconPack icon_pack) {
        var icon_theme_path = user_hicolor_path;

        // TODO check if icon with the same name exists

        foreach (Models.Icon icon in icon_pack.list) {
            var folder_name = @"$(icon.size)x$(icon.size)";
            var size_folder = File.new_for_path (icon_theme_path);
            size_folder = size_folder.get_child (folder_name);

            if (!size_folder.query_exists())
                size_folder.make_directory (); // TODO check error could not create dir

            size_folder = size_folder.get_child ("apps");

            if (!size_folder.query_exists())
                size_folder.make_directory (); // TODO check error could not create dir

            var icon_file = File.new_for_path (icon.path);
            icon_file.copy (size_folder.get_child(@"$(icon_pack.name).png"), FileCopyFlags.NONE);
        }

        App.empty_tmp_dir ();
        install_finished (true);
    }

    private string convert_size_to_folder_name (int size) {
        string folder_name = @"$(size)x$(size)";
        return folder_name;
    }
}