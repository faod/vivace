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

cmake_minimum_required(VERSION 3.1)

project(vivace VERSION 0.0.1 LANGUAGES CXX)

# FindAlleg configuration
set(Alleg_ROOT      ""   CACHE PATH      "Allegro's install directory")
set(Alleg_DEPS_ROOT ""   CACHE PATH      "Allegro's dependencies install directory")
set(Alleg_FIND_DEPS On   CACHE BOOL      "Controls if the CMake script should find Allegro's dependencies")

# Options
option(WANT_IMAGE      "Ability to load/save bitmaps to various image format" On)
option(WANT_TTF        "Ability to load and render TTF fonts" On)
option(WANT_ACODEC     "Ability to load and play sounds" On)
option(WANT_PHYSFS     "Ability to use several ZIP archives are a filesystem" Off)
option(WANT_VIDEO      "Ability to load/play OGG/Theora videos" Off)
option(WANT_DIALOG     "Ability to use Dialogs, a Menu bar, the native file loader and a GUI to display logs" Off)

# Game configuration
set(GAME_SOURCE_DIR    "${CMAKE_CURRENT_SOURCE_DIR}/game/"  CACHE PATH      "Path to the source directory of your game")
set(GAME_NAME          "${PROJECT_NAME}"                    CACHE STRING    "Name of the executable to produce")

# To use bundled cmake modules
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Preprocessor definitions
set(Vivace_Definitions  "GAME_NAME=${GAME_NAME}")
# Include directories
set(Vivace_Include_Dirs "include")
# Libraries to link with
set(Vivace_Libraries Alleg::Allegro Alleg::Main Alleg::Color Alleg::Memfile Alleg::Primitives Alleg::Font)

# Allegro Components to find and Allegro targets to link with
set(Alleg_Components Main Color Memfile Primitives Font)
if(WANT_IMAGE)
  list(APPEND Alleg_Components Image)
  list(APPEND Vivace_Libraries Alleg::Image)
  list(APPEND Vivace_Definitions "WANT_IMAGE")
endif(WANT_IMAGE)
if(WANT_TTF)
  list(APPEND Alleg_Components TTF)
  list(APPEND Vivace_Libraries Alleg::TTF)
  list(APPEND Vivace_Definitions "WANT_TTF")
endif(WANT_TTF)
if(WANT_ACODEC)
  list(APPEND Alleg_Components Audio Acodec)
  list(APPEND Vivace_Libraries Alleg::Audio Alleg::Acodec)
  list(APPEND Vivace_Definitions "WANT_ACODEC")
endif(WANT_ACODEC)
if(WANT_PHYSFS)
  list(APPEND Alleg_Components PhysFS)
  list(APPEND Vivace_Libraries Alleg::PhysFS)
  list(APPEND Vivace_Definitions "WANT_PHYSFS")
endif(WANT_PHYSFS)
if(WANT_VIDEO)
  list(APPEND Alleg_Components Video)
  list(APPEND Vivace_Libraries Alleg::Video)
  list(APPEND Vivace_Definitions "WANT_VIDEO")
endif(WANT_VIDEO)
if(WANT_DIALOG)
  list(APPEND Alleg_Components Dialog)
  list(APPEND Vivace_Libraries Alleg::Dialog)
  list(APPEND Vivace_Definitions "WANT_DIALOG")
endif(WANT_DIALOG)

# Find Allegro
find_package(Alleg 5.2 REQUIRED COMPONENTS ${Alleg_Components})

# Gather sources
set(SOURCES src/init.cpp)

# Helper macro to add source files in the game's cmake script
macro(add_sources)
  foreach(gamesrc ${ARGN})
    list(APPEND SOURCES "${GAME_SOURCE_DIR}/${gamesrc}")
  endforeach()
endmacro(add_sources)

# The game's cmake script
include("${GAME_SOURCE_DIR}/game.cmake")

# Create target
add_executable(${GAME_NAME} ${SOURCES})

# Vivace is written in "modern C++"
set_target_properties(${GAME_NAME} PROPERTIES
  CXX_STANDARD 14
  CXX_STANDARD_REQUIRED ON)

# Add directories to the include search path
target_include_directories(${GAME_NAME} PRIVATE ${Vivace_Include_Dirs})

# Link with dependencies
target_link_libraries(${GAME_NAME} ${Vivace_Libraries})

# Preprocessor definitions
target_compile_definitions(${GAME_NAME} PRIVATE ${Vivace_Definitions})
