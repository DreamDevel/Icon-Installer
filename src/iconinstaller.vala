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

class IconInstaller.App : Granite.Application {
    public static int[] supported_icon_sizes = {16,24,32,48,64,96,128,256,512};

    public static IconInstaller.Windows.MainWindow main_window {get;private set;default = null;}
    public static IconInstaller.App instance;
    public static IconInstaller.Core.IconPackDecoder decoder;
    private static Gtk.FileChooserDialog open_file_dialog;

    public signal void ui_build_finished ();

    construct {
        // Application info
        build_data_dir = Build.DATADIR;
        build_pkg_data_dir = Build.PKG_DATADIR;
        build_release_name = Build.RELEASE_NAME;
        build_version = Build.VERSION;
        build_version_info = Build.VERSION_INFO;

        program_name = "Icon Installer";
        exec_name = "iconinstaller";

        app_copyright = "2015";
        application_id = "org.dreamdev.iconinstaller";
        app_icon = "iconinstaller";
        app_launcher = "iconinstaller.desktop";
        app_years = "2015";

        // TODO change
        main_url = "https://launchpad.net/eradio";
        bug_url = "https://bugs.launchpad.net/eradio/+filebug";
        translate_url = "https://translations.launchpad.net/eradio";
        about_authors = {"George Sofianos <georgesofianosgr@gmail.com>",null};
        help_url = "https://answers.launchpad.net/eradio";
        about_artists = {"George Sofianos <georgesofianosgr@gmail.com>", null};
        about_documenters = { "George Sofianos <georgesofianosgr@gmail.com>",
                                      null };
        about_license_type = Gtk.License.GPL_3_0;

        this.set_flags (ApplicationFlags.FLAGS_NONE);
    }

    public App () {
        instance = this;
    }

    public override void activate () {
        initialize ();
    }

    public void initialize () {
        create_core_objects ();
        create_user_interface ();
    }

    private void create_core_objects () {
        //Notify.init (this.program_name);
        decoder = new Core.IconPackDecoder ();
    }

    private void create_user_interface () {
        create_window ();
        ui_build_finished ();
    }

    private void create_window () {
        main_window = new IconInstaller.Windows.MainWindow ();
    }

    public static File? open_file () {
        open_file_dialog = create_file_dialog ();
        if (open_file_dialog.run () == Gtk.ResponseType.ACCEPT) {
            open_file_dialog.close ();
            return open_file_dialog.get_file ();
        }

        open_file_dialog.close ();
        return null;
    }

    private static Gtk.FileChooserDialog create_file_dialog () {
        var open_file_dialog = new Gtk.FileChooserDialog ("Select a folder with icons or icon file", main_window, 
            Gtk.FileChooserAction.OPEN ,//| Gtk.FileChooserAction.SELECT_FOLDER,
            "_Cancel",
            Gtk.ResponseType.CANCEL,
            "_Open",
            Gtk.ResponseType.ACCEPT);

        open_file_dialog.select_multiple = false;

        var filter_all = new Gtk.FileFilter ();
        filter_all.set_filter_name ("All files");
        filter_all.add_pattern ("*");

        Gtk.FileFilter filter_icons = new Gtk.FileFilter ();
        filter_icons.set_filter_name ("Icon files");
        filter_icons.add_pattern ("*.icon");
        filter_icons.add_pattern ("*.icns");

        //open_file_dialog.add_filter (filter_icons);
        //open_file_dialog.add_filter (filter_all);
        // TODO open folder and files, it is not possible with filechooser

        return open_file_dialog;
    }

    // TODO empty tmp when quiting application
    public static void empty_tmp_dir () {
        var tmp_dir = File.new_for_path (Environment.get_tmp_dir()).get_child(@"$(App.instance.application_id)");

        var tmp_dir_files = Core.FileSystem.get_files (tmp_dir.get_path());
        foreach (File file in tmp_dir_files) {
            file.delete ();
        }

        tmp_dir.delete ();
    }
}