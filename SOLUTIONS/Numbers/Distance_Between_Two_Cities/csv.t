@csv.h=
#pragma once
@includes

@functions

@csv.cpp=
#include "csv.h"

@define_functions

@includes=
#include <iostream>
#include <vector>
#include <string>

@functions=
auto readCSV(std::istream& in, std::vector<std::vector<std::string>>& v) -> void;

@define_functions=
auto readCSV(std::istream& in, std::vector<std::vector<std::string>>& v) -> void
{
	std::string line;
	while(std::getline(in, line)) {
		@init_list
		@separate_by_comma
		@remove_string_delimiters
		@add_list_to_v
	}
}

@init_list=
std::vector<std::string> vi;

@separate_by_comma=
size_t s = 0, i = 0;
while(s+i < line.size()) {
	if(line[s+i] == ',') {
		vi.push_back(line.substr(s, i));
		s += i+1;
		i = 0;
	} else {
		i++;
	}
}

if(i > 0) {
	vi.push_back(line.substr(s, i));
}

@remove_string_delimiters=
for(auto& vii : vi) {
	vii = vii.substr(1, vii.size()-2);
}

@add_list_to_v=
v.push_back(vi);
