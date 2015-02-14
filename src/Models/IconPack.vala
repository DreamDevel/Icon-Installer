using Gee;

public class IconInstaller.Models.IconPack {

    public IconPack () {
        name = "";
        list = new ArrayList <Models.Icon> ();
    }

    public IconPack.with_list (ArrayList <Models.Icon> icon_list) {
        name = "";
        list = icon_list;
    }

    public IconPack.with_list_and_name (ArrayList <Models.Icon> icon_list,string icon_pack_name) {
        name = icon_pack_name;
        list = icon_list;
    }

    public string name;
    public ArrayList<Models.Icon> list;
}