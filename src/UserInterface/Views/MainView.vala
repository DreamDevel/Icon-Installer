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

 public class IconInstaller.Views.MainView : Gtk.Bin {

    private Gtk.Box main_box;
    private Gtk.Box sizes_box;
    private Gtk.ButtonBox buttons_box;
    private Gtk.Button cancel_button;
    private Gtk.Button install_button;
    private Gtk.Image icon_preview;
    private Gtk.Entry name_entry;

    private HashMap <string,Widgets.TrueFalseBox> truefalse_boxes_list;  

    public MainView () {
        build_interface ();
        connect_handlers_to_internal_signals ();
        connect_handlers_to_external_signals ();
    }

    private void build_interface () {
        create_main_box ();
        create_icon_preview ();
        create_name_entry ();
        create_sizes_box ();
        create_buttons_box ();
        append_widgets ();

        add (main_box);
        show_all ();
    }

    private void create_main_box () {
        main_box = new Gtk.Box (Gtk.Orientation.VERTICAL,6);
        main_box.margin = 12;
    }

    private void create_icon_preview () {
        icon_preview = new Gtk.Image ();
        icon_preview.margin_bottom = 6;
    }

    private void create_name_entry () {
        name_entry = new Gtk.Entry ();
        name_entry.margin_left = 80;
        name_entry.margin_right = 80;
        name_entry.set_alignment ((float)0.5);
    }

    private void create_sizes_box () {
        sizes_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL,6);
        sizes_box.margin_top = 12;
        sizes_box.margin_bottom = 12;

        // Add boxes to hashlist and box
        truefalse_boxes_list = new HashMap <string,Widgets.TrueFalseBox> ();
        foreach (int size in App.supported_icon_sizes) {
            var truefalse_box = new IconInstaller.Widgets.TrueFalseBox (@"$(size)px",false);
            truefalse_boxes_list[@"$size"] = truefalse_box;
            sizes_box.pack_start (truefalse_box);
        }
    }

    private void create_buttons_box () {
        buttons_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
        buttons_box.set_layout (Gtk.ButtonBoxStyle.END);
        buttons_box.valign = Gtk.Align.END;
        buttons_box.set_spacing (6);
        cancel_button = new Gtk.Button.with_label ("Cancel");
        install_button = new Gtk.Button.with_label ("Install");
        install_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        buttons_box.add (cancel_button);
        buttons_box.add (install_button);
    }

    private void append_widgets () {
        main_box.pack_start (icon_preview);
        main_box.pack_start (name_entry);
        main_box.pack_start (sizes_box,false);
        main_box.pack_start (buttons_box);
    }

    private void connect_handlers_to_internal_signals () {
        install_button.clicked.connect (handle_install_button_clicked);
        cancel_button.clicked.connect (handle_cancel_button_clicked);
        name_entry.changed.connect (handle_name_entry_text_changed);
    }

    private void handle_install_button_clicked () {
        App.installer.install (App.current_icon_pack);
    }

    private void handle_cancel_button_clicked () {
        reset ();
        App.empty_tmp_dir ();
        App.main_window.view_stack.change_to_view_with_name("welcome");
    }

    private void handle_name_entry_text_changed () {
        App.current_icon_pack.name = name_entry.text;
    }

    private void connect_handlers_to_external_signals () {
        IconInstaller.App.decoder.decode_finished.connect (handle_decode_finished);
    }

    private void handle_decode_finished (Models.IconPack icon_pack) {
        reset ();
        name_entry.text = icon_pack.name;

        bool preview_icon_set = false;
        int list_size = icon_pack.list.size;
        int iterate = 0;
        foreach (Models.Icon icon in icon_pack.list) {
            truefalse_boxes_list[@"$(icon.size)"].set_true ();

            // Set icon size 64 or larger, otherwise set largest available
            iterate++;
            if (icon.size >= 64 || (list_size == iterate && !preview_icon_set) ) {
                set_icon (icon.path);
            }
        }

        App.main_window.view_stack.change_to_view_with_name("main_view");
    }

    private void set_icon (string path) {
        var pix_preview = new Gdk.Pixbuf.from_file_at_size (path,64,64);
        icon_preview.set_from_pixbuf (pix_preview);
    }

    private void set_icon_name (string icon_name) {
        name_entry.text = icon_name;
    }

    private void reset () {
        foreach (int size in App.supported_icon_sizes) {
            truefalse_boxes_list[@"$(size)"].set_false ();
        }
    }
 }