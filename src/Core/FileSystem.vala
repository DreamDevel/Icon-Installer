using Gee;

class IconInstaller.Core.FileSystem {

	public static bool is_file (string path) {
		var working_file = File.new_for_path (path);
		// TODO file may not exist
	    var info = working_file.query_info ("standard::*",0);
	    return (info.get_file_type () == FileType.REGULAR);
	}

	public static string get_file_name_without_ext (File file) {
		var file_name = file.get_basename ();
		var index_of_last_dot = file_name.last_index_of (".");
		if (index_of_last_dot != -1)
		    file_name = file_name.slice (0,index_of_last_dot);

		return file_name;
	}
	
	public static ArrayList<File> get_directories (string path) {
		var working_directory = File.new_for_path (path);
		// TODO check if path exists
		var enumerator = working_directory.enumerate_children ("standard::*",FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
		FileInfo file_info;
		var directories = new ArrayList<File>();

		while ( (file_info = enumerator.next_file ()) != null) {
			if (file_info.get_file_type () == FileType.DIRECTORY) {
				File directory = working_directory.resolve_relative_path (file_info.get_name ());
				directories.add (directory);
			}
		}
		return directories;
	}

	public static ArrayList<File> get_files (string path) {
		var working_directory = File.new_for_path (path);
		// TODO check if path exists
		var enumerator = working_directory.enumerate_children ("standard::*",FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
		FileInfo file_info;
		var files = new ArrayList<File>();

		while ( (file_info = enumerator.next_file ()) != null) {
			if (file_info.get_file_type () == FileType.REGULAR) {
				File file = working_directory.resolve_relative_path (file_info.get_name ());
				files.add (file);
			}
		}
		return files;
	}
}