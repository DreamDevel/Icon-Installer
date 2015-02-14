/*-
 *  Copyright (c) 2014 George Sofianos
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
 *
 */

public class IconInstaller.Widgets.HeaderBar : Gtk.HeaderBar {

    private Gtk.ToolButton open_button;
    private Granite.Widgets.AppMenu application_menu;
    private Gtk.Label title;

    public HeaderBar () {
        initialize ();
        build_interface ();
        connect_handlers_to_internal_signals ();
    }

    private void initialize () {
        show_close_button = true;
    }

    private void build_interface () {
        create_application_menu ();
        create_open_button ();
        create_title ();
        append_headerbar_items ();
    }

    private void create_application_menu () {
        application_menu = (new IconInstaller.Menus.ApplicationMenu ()).get_as_granite_app_menu ();
    }

    private void create_open_button () {
        var icon_size = Gtk.IconSize.LARGE_TOOLBAR;
        var open_button_image = new Gtk.Image.from_icon_name("document-open",icon_size);
        open_button = new Gtk.ToolButton (open_button_image,"");
    }

    private void create_title () {
        title = new Gtk.Label ("");
        title.set_markup ("<b>Icon Installer</b>");
    }

    private void append_headerbar_items () {
        pack_start (open_button);
        pack_end (application_menu);
        set_custom_title (title);
    }
    
    private void connect_handlers_to_internal_signals () {
        open_button.clicked.connect (handle_open_button_clicked);
    }

    private void handle_open_button_clicked () {
        var file = App.open_file ();
        if (file != null) {
            App.decoder.decode (file.get_path ());
        }
    }
}