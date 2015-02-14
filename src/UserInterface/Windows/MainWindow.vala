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

using Gtk;

class IconInstaller.Windows.MainWindow : Window {

    public Widgets.HeaderBar headerbar;
    public Widgets.ViewStack view_stack;

	public MainWindow () {
        set_properties ();
        build_interface ();
	}

    private void set_properties () {
        set_application (IconInstaller.App.instance);
        resizable = false;
    }

    private void build_interface () {
        create_headerbar ();
        create_view_stack ();
        add (view_stack);
        show_all ();
    }

    private void create_headerbar () {
        headerbar = new Widgets.HeaderBar ();
        set_titlebar(headerbar);
    }

    private void create_view_stack () {
        view_stack = new Widgets.ViewStack ();
    }
}