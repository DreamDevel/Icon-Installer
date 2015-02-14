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