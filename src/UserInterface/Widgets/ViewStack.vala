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

public class IconInstaller.Widgets.ViewStack : Gtk.Stack {

	public IconInstaller.Views.WelcomeView welcome_view;
    public IconInstaller.Views.MainView main_view;
    public IconInstaller.Views.SuccessView success_view;

    public ViewStack () {
        build_interface ();
    }

    private void build_interface () {
        set_properties ();
    	create_views ();
    	append_views_to_stack ();
    }

    private void set_properties () {
        width_request = 500;
        height_request = 270;
    }

    private void create_views () {
    	welcome_view = new IconInstaller.Views.WelcomeView ();
    	main_view = new IconInstaller.Views.MainView ();
        success_view = new IconInstaller.Views.SuccessView ();
    }

    private void append_views_to_stack () {
    	add_named (welcome_view,"welcome");
    	add_named (main_view,"main_view");
        add_named (success_view,"success_view");
    }

    public void change_to_view_with_name (string view_name) {
        assign_animation_for_view (view_name);
        set_visible_child_name (view_name);
    }

    public void assign_animation_for_view (string view_name) {
        Gtk.StackTransitionType transition_type = Gtk.StackTransitionType.NONE;
        switch (visible_child_name) {
            case "welcome":
               transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
               break;
            case "success_view":
            case "failure_view":
                transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                break;
            case "main_view":
                transition_type = (view_name == "welcome") ?
                Gtk.StackTransitionType.SLIDE_RIGHT : Gtk.StackTransitionType.SLIDE_LEFT;
                break;
        }

        set_transition_type (transition_type);
    }


}