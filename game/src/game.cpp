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

using namespace vivace;

#include <exception>
#include <iostream>
#include <string>

using namespace std;

int main(void) {
	try {
		Vivace engine("GAME_NAME"s, ""s);
		ALLEGRO_DISPLAY *dsp = al_create_display(800, 600);
		al_clear_to_color(al_map_rgb(0, 255, 0));
		al_flip_display();
		al_rest(10.0);
		al_destroy_display(dsp);
	}
	catch (std::exception ex) {
		std::cerr << ex.what() << std::endl;
	}
}
