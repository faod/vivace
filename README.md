# Vivace, the Allegro engine

Vivace is a pure C++ game engine built on Allegro, the game library.

Vivace's goal is to speed-up the development of a C++ game (2D and 3D) using Allegro and OpenGL.

## Features

* All features provided by [Allegro ver. 5](http://liballeg.org/a5docs/trunk/) are available in Vivace.

## Dependencies

* The [Allegro](http://liballeg.org/) game library.
* The [CMake](https://cmake.org/) build system builder.

## Compile

How to build Vivace in 2 steps:

### Generate build files

Using the [CMake](https://cmake.org/) build system builder, use the `cmake` command, or the ccmake or cmake-gui
utilities to generate a Makefile or Project files for your favorite IDE.

The CMake script declares the following variables to configure your project:

* Where to find Allegro and its dependencies:
  * *Alleg_ROOT*        (Path)  - Allegro's install directory (should contain `include` and `lib` sub directories).
  * *Alleg_DEPS_ROOT*   (Path)  - Allegro's dependencies install directory.
  * *Alleg_FIND_DEPS*   (Bool)  - Controls if the CMake script should find Allegro's dependencies.
* Enabling features:
  * *WANT_IMAGE*        (Bool)  - Ability to load/save bitmaps to various image format.
  * *WANT_TTF*          (Bool)  - Ability to load and render TTF fonts.
  * *WANT_AUDIO*        (Bool)  - Ability to load and play sounds.
  * *WANT_PHYSFS*       (Bool)  - Ability to use several ZIP archives are a filesystem.
  * *WANT_VIDEO*        (Bool)  - Ability to load/play OGG/Theora videos.
  * *WANT_DIALOG*       (Bool)  - Ability to use Dialogs, a Menu bar, the native file loader and a GUI to display logs.
* Building your game:
  * *GAME_SOURCE_DIR*   (Path)  - Path to the source directory of your game (must contains a game.cmake that adds the
    game's sources to the SOURCE variable).
  * *GAME_NAME*       (String)  - Name of the executable to produce, defaults to `"vivace"`

Look at the output log of cmake to see if every required package/components are found, then proceed with the build.

### Compile

Once you have your makefile / project files generated, it's up to you to use it to build your game.

## Example

See the `game/` directory.

## Documentation

TBD.
