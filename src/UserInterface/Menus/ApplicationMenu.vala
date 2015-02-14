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

public class IconInstaller.Menus.ApplicationMenu : Gtk.Menu {

    private Gtk.MenuItem donate_item;

    public ApplicationMenu () {
        build_interface ();
        //connect_handlers_to_internal_signals ();
    }

    private void build_interface () {
        create_menu_entries ();
        append_menu_entries ();
    }

    private void create_menu_entries () {
        donate_item = new Gtk.MenuItem.with_label (_("Donate"));
    }

    private void append_menu_entries () {
        //append (new Gtk.SeparatorMenuItem ());
        append (donate_item);
    }

    public Granite.Widgets.AppMenu get_as_granite_app_menu () {
        return  IconInstaller.App.instance.create_appmenu (this);
    }
}