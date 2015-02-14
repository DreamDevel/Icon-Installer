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

public class IconInstaller.Views.WelcomeView : Granite.Widgets.Welcome {


    public WelcomeView () {
    	base ("Install Icons",_("Choose a file or folder to install"));
        build_interface ();
    }

    private void build_interface () {
    	append_welcome_entries ();
        connect_handlers_to_internal_signals ();
        show_all ();
    }


    private void append_welcome_entries () {
    	var open_image = new Gtk.Image.from_icon_name("document-open",Gtk.IconSize.DND);
        var open_image2 = new Gtk.Image.from_icon_name("document-open",Gtk.IconSize.DND);
    	open_image.set_pixel_size (128);
        open_image2.set_pixel_size (128);
    	append_with_image (open_image,_("Open"),_("Open an icon/icns file"));
        append_with_image (open_image2,_("Open"),_("Open a folder with icons"));
    }

    private void connect_handlers_to_internal_signals () {
        activated.connect (handle_welcome_menu_click);
    }

    private void handle_welcome_menu_click (int index) {
        if (index == 1) {
           var file = App.open_file ();
           if (file != null) {
               App.decoder.decode (file.get_path ());
           }
        }
    }
}