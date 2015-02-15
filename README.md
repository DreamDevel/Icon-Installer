# Icon Installer
**Easily install .icns .icon and png icons to elementary OS** 

![](http://i.imgur.com/2QeH6Ox.png)

 ```
Project is under development. Please report bugs or create pull requests after the version 1.0 is released. 
```

Visit our web page for more info : http://www.dreamdevel.com/apps/iconinstaller 

```Note: Web page under construction```

##Install Build Dependencies

**For elementary OS Freya and other ubuntu based distributions** 

```
Navigate to project's tools directory via terminal and run ./install-deps
```

**Note for ubuntu based distributions**

You may need to include elementary OS repository for the latest libgranite library
 
```
sudo add-apt-repository ppa:elementary-os/stable
```

##Build & Run

**If you are using Sublime Text 3**

* Open iconinstaller.sublime-project with sublime
* Go to menu Tools -> Build System -> Vala/Cmake
* Press ctrl+b to build the project
* Navigate via terminal to build directory and run 'sudo make install' (1 time only)
* Press ctrl+shift+b to run the project

**If you are using the terminal - The simple way**

* Run **. dev-shell** in the tools directory to add tools to your $PATH temporary
* Run **build** from any directory to build the project
* Navigate via terminal to build directory and run 'sudo make install' (1 time only)
* Run **run** from any directory to run the project

**If you are using the terminal - The normal way**

* Navigate to the **build** directory
* Run **cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make** to build the project
* Navigate via terminal to build directory and run 'sudo make install' (1 time only)
* Run **./iconinstaller** to run the project

## Installation

After you build the project run **sudo make install** from the **build** directory
