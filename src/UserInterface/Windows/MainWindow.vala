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