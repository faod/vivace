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

#ifndef V_BASE_HPP
#define V_BASE_HPP
#pragma once

#include <stdexcept>

namespace vivace {

class Vivace {
public:
	// Initialises the engine, call only once
	Vivace(const std::string &app_name, const std::string &org_name);

	Vivace(Vivace &)         = delete;
	void operator=(Vivace &) = delete;

	~Vivace();
};

// Exceptions thrown by the engine are instances of this class
class Vivace_Error: public std::runtime_error {
public:
	Vivace_Error(const std::string &reason): runtime_error(reason) {}
	Vivace_Error(const char *reason):        runtime_error(reason) {}
};

}

#endif // V_BASE_HPP