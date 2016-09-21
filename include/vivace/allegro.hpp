/*
	Copyright 2016 Jonathan Bayle, Thomas Medioni

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

#ifndef ALLEGRO_HPP
#define ALLEGRO_HPP
#pragma once

#include <allegro5/allegro.h>
#include <allegro5/allegro_audio.h>
#include <allegro5/allegro_color.h>
#include <allegro5/allegro_font.h>
#include <allegro5/allegro_memfile.h>
#include <allegro5/allegro_primitives.h>

#ifdef WANT_IMAGE
#include <allegro5/allegro_image.h>
#endif

#ifdef WANT_ACODEC
#include <allegro5/allegro_acodec.h>
#endif

#ifdef WANT_TTF
#include <allegro5/allegro_ttf.h>
#endif

#ifdef WANT_PHYSFS
#include <allegro5/allegro_physfs.h>
#endif

#ifdef WANT_VIDEO
#include <allegro5/allegro_video.h>
#endif

#ifdef WANT_DIALOG
#include <allegro5/allegro_native_dialog.h>
#endif

#endif /* ALLEGRO_HPP */

