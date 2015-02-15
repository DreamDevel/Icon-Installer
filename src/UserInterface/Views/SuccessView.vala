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

 public class IconInstaller.Views.SuccessView : Gtk.Bin {
    Gtk.Box main_box;
    Gtk.Image top_image;
    Gtk.Label label;
    Gtk.Button done_button;

    public SuccessView () {
        build_interface ();
        connect_handlers_to_internal_signals ();
        connect_handlers_to_external_signals ();
    }

    private void build_interface () {
        create_main_box ();
        create_top_image ();
        create_label ();
        create_done_button ();
        append_widgets ();
        show_all ();
    }

    private void create_main_box () {
        main_box = new Gtk.Box (Gtk.Orientation.VERTICAL,6);
        main_box.margin = 12;
        main_box.margin_top = 70;
    }

    private void create_top_image () {
        top_image = new Gtk.Image.from_icon_name("dialog-ok",Gtk.IconSize.DIALOG);
    }

    private void create_label () {
        label = new Gtk.Label ("Installation was successful");
    }

    private void create_done_button () {
        done_button = new Gtk.Button.with_label ("Done");
        done_button.halign = Gtk.Align.CENTER;
        done_button.width_request = 70;
        done_button.margin_top = 6;
    }

    private void append_widgets () {
        main_box.pack_start (top_image,false);
        main_box.pack_start (label,false);
        main_box.pack_start (done_button,false);
        add (main_box);
    }

    private void connect_handlers_to_internal_signals () {
        done_button.clicked.connect (handle_done_button_clicked);
    }

    private void handle_done_button_clicked () {
        App.main_window.view_stack.change_to_view_with_name ("welcome");
    }

    private void connect_handlers_to_external_signals () {
        App.installer.install_finished.connect (handle_install_finished);
    }

    private void handle_install_finished (bool was_success) {
        if (was_success)
            App.main_window.view_stack.change_to_view_with_name ("success_view");
    }
 }