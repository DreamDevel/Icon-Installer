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