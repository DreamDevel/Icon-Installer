
project (iconinstaller)
cmake_minimum_required (VERSION 2.6)
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(GETTEXT_PACKAGE ${CMAKE_PROJECT_NAME})
add_definitions("-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\"")
add_definitions("-w")

set (HOMEDIR $ENV{HOME})
set (HOME_DATADIR ${HOMEDIR}/.local/share/dreamiconinstaller)
set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/iconinstaller")
set (PKG_DATADIR ${PKGDATADIR})

set (EXEC_NAME "iconinstaller")
set (RELEASE_NAME "Icon Installer")
set (VERSION "1.0")

set (CONFIG_FILE ${CMAKE_CURRENT_SOURCE_DIR}/src/config.vala)
set (CONFIG_FILE_REL src/config.vala)
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/src/config.vala.cmake ${CONFIG_FILE})

find_package(PkgConfig)

set (PROJECT_DEPS
    gtk+-3.0
    granite
    gee-0.8
    libnotify
    gio-2.0
)

pkg_check_modules(DEPS REQUIRED ${PROJECT_DEPS})

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.24" MINIMUM)
include(ValaPrecompile)

vala_precompile(VALA_C ${EXEC_NAME}
    ${CONFIG_FILE_REL}
    src/UserInterface/Windows/MainWindow.vala

    src/UserInterface/Menus/ApplicationMenu.vala
    
    src/UserInterface/Widgets/HeaderBar.vala
    src/UserInterface/Widgets/ViewStack.vala
    src/UserInterface/Widgets/TrueFalseBox.vala

    src/UserInterface/Views/WelcomeView.vala
    src/UserInterface/Views/MainView.vala

    src/Core/FileSystem.vala
    src/Core/IconPackDecoder.vala

    src/Models/Icon.vala
    src/Models/IconPack.vala

    src/iconinstaller.vala
    src/main.vala
PACKAGES
    ${PROJECT_DEPS}
    posix
)

add_subdirectory (po)

add_executable(${EXEC_NAME} ${VALA_C})
install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/iconinstaller.desktop DESTINATION ${DATADIR}/applications/)

set(SYSTEM_DEFAULT_THEME ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/tick.png DESTINATION ${PKGDATADIR}/images/)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/dash.png DESTINATION ${PKGDATADIR}/images/)
#TODO install application's icon
#install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/icons/16x16/apps/eradio.png DESTINATION ${SYSTEM_DEFAULT_THEME}/16x16/apps)
#install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/icons/24x24/apps/eradio.png DESTINATION ${SYSTEM_DEFAULT_THEME}/24x24/apps)
#install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/icons/32x32/apps/eradio.png DESTINATION ${SYSTEM_DEFAULT_THEME}/32x32/apps)
#install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/icons/48x48/apps/eradio.png DESTINATION ${SYSTEM_DEFAULT_THEME}/48x48/apps)
#install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/icons/64x64/apps/eradio.png DESTINATION ${SYSTEM_DEFAULT_THEME}/64x64/apps)
#install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/icons/96x96/apps/eradio.png DESTINATION ${SYSTEM_DEFAULT_THEME}/96x96/apps)
#install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/images/icons/128x128/apps/eradio.png DESTINATION ${SYSTEM_DEFAULT_THEME}/128x128/apps)