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

public class IconInstaller.Widgets.TrueFalseBox : Gtk.Bin {
    
    private Gtk.Box box;
    private Gtk.Label label;
    private Gtk.Image image;

    public TrueFalseBox (string label_str,bool isTrue=true) {
        box = new Gtk.Box (Gtk.Orientation.VERTICAL,3);
        label = new Gtk.Label (label_str);
        image = new Gtk.Image ();

        if (isTrue)
            set_true ();
        else 
            set_false ();

        box.pack_start (image,false);
        box.pack_start (label,false);
        add (box);
    }

    public void set_true () {
        // TODO set path to .local/share/images/
        var pix = new Gdk.Pixbuf.from_file_at_size ("/usr/share/iconinstaller/images/tick.png",
            24,24);
        image.set_from_pixbuf (pix);
    }

    public void set_false () {
        var pix = new Gdk.Pixbuf.from_file_at_size ("/usr/share/iconinstaller/images/dash.png",
            24,24);
        image.set_from_pixbuf (pix);
    }
}