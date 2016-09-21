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

#include <vivace/vivace.hpp>
#include <vivace/allegro.hpp>

#include <string>

namespace vivace {

Vivace::Vivace(const std::string &app_name, const std::string &org_name)
{
	if (!app_name.empty()) {
		al_set_app_name(app_name.c_str());
	}
	if (org_name.empty()) {
		al_set_org_name(org_name.c_str());
	}

	if (!al_init()) {
		throw Vivace_Error("failed to initialize allegro!");
	}

	al_install_keyboard();
	al_install_mouse();
	al_install_joystick();
	al_init_font_addon();
	al_init_primitives_addon();

#ifdef WANT_IMAGE
	al_init_image_addon();
#endif

#ifdef WANT_ACODEC
	al_init_acodec_addon();
#endif

#ifdef WANT_TTF
	al_init_ttf_addon();
#endif

#ifdef WANT_VIDEO
	al_init_video_addon();
#endif

#ifdef WANT_DIALOG
	al_init_native_dialog_addon();
#endif
}

Vivace::~Vivace()
{
	al_uninstall_system();
}

}
