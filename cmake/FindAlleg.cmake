#.rst:
# FindAlleg
# --------
#
# Find Allegro5 includes and libraries.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the following `IMPORTED` targets:
#
#  - ``Alleg::Allegro``
#
# And the following `IMPORTED` component targets:
#
#  - ``Alleg::Acodec``,
#  - ``Alleg::Audio``,
#  - ``Alleg::Color``,
#  - ``Alleg::Dialog``,
#  - ``Alleg::Font``,
#  - ``Alleg::Image``,
#  - ``Alleg::Main``,
#  - ``Alleg::Memfile``,
#  - ``Alleg::PhysFS``,
#  - ``Alleg::Primitives``,
#  - ``Alleg::TTF``,
#  - ``Alleg::Video``.
#
# Components
# ^^^^^^^^^^
#
# This module has the following components:
#
#  - Acodec,
#  - Audio,
#  - Color,
#  - Dialog,
#  - Font,
#  - Image,
#  - Main,
#  - Memfile,
#  - PhysFS,
#  - Primitives,
#  - TTF,
#  - Video.
#
# Input Variables
# ^^^^^^^^^^^^^^^
#
#  - Alleg_FIND_DEPS - True to add interface libraries needed by Allegro.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
#  - Alleg_FOUND          - True if Allegro found.
#
#  - Alleg_VERSION_STRING - The version of Allegro found (x.y.z)
#  - Alleg_VERSION_MAJOR  - The major version of Allegro
#  - Alleg_VERSION_MINOR  - The minor version of Allegro
#  - Alleg_VERSION_PATCH  - The patch version of Allegro
#
# Hints
# ^^^^^
#
# A user may set ``Alleg_ROOT`` to an Alleg installation root to tell this
# module where to look.
#
# A user may set ``Alleg_DEPS_ROOT`` to the root directory containing allegro's
# dependencies to tell this module where to look.

#=============================================================================
# Copyright 2016 Jonathan Bayle, Thomas Medioni
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#=============================================================================

# User supplied hints
if(NOT Alleg_ROOT)
  set(Alleg_ROOT "")
endif()
if(NOT Alleg_DEPS_ROOT)
  set(Alleg_DEPS_ROOT "")
endif()

# Call find_library for each components and set the WANT_* and *_FOUND variables
macro(find_component COMP LIBNAME)
  # Find release libs
  find_library(Alleg_${COMP}        NAMES "${LIBNAME}"       "${LIBNAME}-static"        HINTS ${Alleg_ROOT}  PATH_SUFFIXES "lib")
  # Find debug libs
  find_library(Alleg_${COMP}_DEBUG  NAMES "${LIBNAME}-debug" "${LIBNAME}-debug-static"  HINTS ${Alleg_ROOT}  PATH_SUFFIXES "lib")
  # Set _FOUND var
  set(Alleg_${COMP}_FOUND FALSE)
  if(Alleg_${COMP} OR Alleg_${COMP}_DEBUG)
    set(Alleg_${COMP}_FOUND TRUE)
  endif()
  # Set WANT_ var
  set(WANT_Alleg_${COMP} FALSE)
  list(FIND Alleg_FIND_COMPONENTS "${COMP}" WANT_COMP)
  if(NOT WANT_COMP EQUAL "-1")
    set(WANT_Alleg_${COMP} TRUE)
  endif()
  mark_as_advanced(Alleg_${COMP} Alleg_${COMP}_DEBUG)
endmacro(find_component)

# Find headers
find_path(Alleg_INCLUDE_DIR NAMES "allegro5/allegro5.h" HINTS ${Alleg_ROOT} PATH_SUFFIXES "include")
mark_as_advanced(Alleg_INCLUDE_DIR)

# Find components
find_component(Allegro     allegro)
find_component(Acodec      allegro_acodec)
find_component(Audio       allegro_audio)
find_component(Color       allegro_color)
find_component(Dialog      allegro_dialog)
find_component(Font        allegro_font)
find_component(Image       allegro_image)
find_component(Main        allegro_main)
find_component(Memfile     allegro_memfile)
find_component(PhysFS      allegro_physfs)
find_component(Primitives  allegro_primitives)
find_component(TTF         allegro_ttf)
find_component(Video       allegro_video)

# Extract version numbers
if(Alleg_INCLUDE_DIR AND EXISTS "${Alleg_INCLUDE_DIR}/base.h")
  file(STRINGS "${Alleg_INCLUDE_DIR}/base.h" Alleg_VER_DEF REGEX "^#define ALLEGRO_VERSION_STR +\"[^\"]+\"$")
  string(REGEX REPLACE "^[^\"]+\"([^\"]+)\".+$"       "\\1" Alleg_VERSION_STRING "${Alleg_VER_DEF}")
  string(REGEX REPLACE "^([0-9]+).*$"                 "\\1" Alleg_VERSION_MAJOR  "${Alleg_VERSION_STRING}")
  string(REGEX REPLACE "^[0-9]+\.([0-9]+).*$"         "\\1" Alleg_VERSION_MINOR  "${Alleg_VERSION_STRING}")
  string(REGEX REPLACE "^[0-9]+\.[0-9]+\.([0-9]+).*$" "\\1" Alleg_VERSION_PATCH  "${Alleg_VERSION_STRING}")
  # the ALLEGRO_UNSTABLE_BIT and ALLEGRO_RELEASE_NUMBER definitions are ignored
  set(Alleg_VERSION_TWEAK "")
  set(Alleg_VERSION_COUNT "3")
endif()

# Find a dependency of given Target and set it as INTERFACE_LINK_LIBRARIES (if Alleg_FIND_DEPS is ON)
macro(find_dependency TARGET VARNAME) # all args after `varname` are names of the library to find
  if(Alleg_FIND_DEPS)
    find_library(${VARNAME}  NAMES ${ARGN}  HINTS ${Alleg_DEPS_ROOT} ${Alleg_ROOT}  PATH_SUFFIXES "lib")
    if (${VARNAME})
      set_target_properties(${TARGET} PROPERTIES INTERFACE_LINK_LIBRARIES ${${VARNAME}})
    endif(${VARNAME})
  endif(Alleg_FIND_DEPS)
endmacro(find_dependency)

# Make Alleg::Allegro IMPORTED target
if(Alleg_Allegro_FOUND)
  add_library(Alleg::Allegro UNKNOWN IMPORTED)
  set_target_properties(Alleg::Allegro PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${Alleg_INCLUDE_DIR}"
    IMPORTED_LOCATION ${Alleg_Allegro}
    IMPORTED_LOCATION_DEBUG ${Alleg_Allegro_DEBUG})

  if(Alleg_FIND_DEPS)
    find_package(OpenGL)
    set(AL_DEPS ${OPENGL_gl_LIBRARY})
    if(WIN32)
      LIST(APPEND AL_DEPS "shlwapi" "psapi" "winmm" "Gdiplus")
      if(NOT MSVC)
        list(APPEND AL_DEPS "stdc++")
      endif()
    endif(WIN32)
    set_target_properties(Alleg::Allegro PROPERTIES INTERFACE_LINK_LIBRARIES "${AL_DEPS}")
  endif(Alleg_FIND_DEPS)
endif()

# Make Alleg::COMP IMPORTED component targets
macro(add_imported_component COMP DEP)
  add_library(Alleg::${COMP} UNKNOWN IMPORTED)
  add_dependencies(Alleg::${COMP} Alleg::${DEP})
  set_target_properties(Alleg::${COMP} PROPERTIES IMPORTED_LOCATION       ${Alleg_${COMP}})
  set_target_properties(Alleg::${COMP} PROPERTIES IMPORTED_LOCATION_DEBUG ${Alleg_${COMP}_DEBUG})
endmacro(add_imported_component)

if(Alleg_Audio_FOUND AND WANT_Alleg_Audio)
  add_imported_component(Audio Allegro)
  find_dependency(Alleg::Audio  OPENAL  "OpenAL" "openal")
endif()

if(Alleg_Acodec_FOUND AND WANT_Alleg_Acodec)
  add_imported_component(Acodec Audio)
  find_dependency(Alleg::Acodec  DUMB        "dumb")
  find_dependency(Alleg::Acodec  FLAC        "FLAC")
  find_dependency(Alleg::Acodec  OGG         "ogg")
  find_dependency(Alleg::Acodec  VORBIS      "vorbis")
  find_dependency(Alleg::Acodec  VORBISFILE  "vorbisfile")
endif()

if(Alleg_Color_FOUND AND WANT_Alleg_Color)
  add_imported_component(Color Allegro)
endif()

if(Alleg_Dialog_FOUND AND WANT_Alleg_Dialog)
  add_imported_component(Dialog Allegro)
endif()

if(Alleg_Font_FOUND AND WANT_Alleg_Font)
  add_imported_component(Font Allegro)
endif()

if(Alleg_TTF_FOUND AND WANT_Alleg_TTF)
  add_imported_component(TTF Font)
  find_dependency(Alleg::TTF  FREETYPE  "freetype")
endif()

if(Alleg_Image_FOUND AND WANT_Alleg_Image)
  add_imported_component(Image Allegro)
  find_dependency(Alleg::Image  JPEG   "jpeg")
  find_dependency(Alleg::Image  PNG16  "png16" "libpng16")
endif()

if(Alleg_Main_FOUND AND WANT_Alleg_Main)
  add_imported_component(Main Allegro)
endif()

if(Alleg_Memfile_FOUND AND WANT_Alleg_Memfile)
  add_imported_component(Memfile Allegro)
endif()

if(Alleg_PhysFS_FOUND AND WANT_Alleg_PhysFS)
  add_imported_component(PhysFS Allegro)
  find_dependency(Alleg::PhysFS  PHYSFS  "physfs")
  find_dependency(Alleg::PhysFS  ZLIB    "z" "zlib" "zdll")
endif()

if(Alleg_Primitives_FOUND AND WANT_Alleg_Primitives)
  add_imported_component(Primitives Allegro)
endif()

if(Alleg_Video_FOUND AND WANT_Alleg_Video)
  add_imported_component(Video Allegro)
  find_dependency(Alleg::Video  OGG          "ogg")
  find_dependency(Alleg::Video  THEORACODEC  "theoracodec")
  find_dependency(Alleg::Video  VORBIS       "vorbis")
  find_dependency(Alleg::Video  VORBISFILE   "vorbisfile")
endif()

# Verify Alleg version and components
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Alleg  REQUIRED_VARS Alleg_INCLUDE_DIR  VERSION_VAR Alleg_VERSION_STRING  HANDLE_COMPONENTS)
