@*=
@includes

@city_struct

auto main() -> int
{
	@load_csv
	@postprocess_data

	@ask_user
	@compute_distance
	@print_distance

	system("PAUSE");
	return 0;
}

@includes=
#include "csv.h"
#include <vector>
#include <string>
#include <fstream>
#include <iostream>

@load_csv=
std::vector<std::vector<std::string>> v;
{
	std::ifstream in("..\\worldcities.csv");
	if(!in.is_open()) {
		std::cout << "ERROR: Could not open worldcities.csv" << std::endl;
		return EXIT_FAILURE;
	}

	readCSV(in, v);
}

@includes+=
#include "vec2.h"

@city_struct=
struct City
{
	Vec2d pos;
};

@includes+=
#include <sstream>
#include <map>
#include "string_utils.h"

@postprocess_data=
v.erase(v.begin());

std::map<std::string, City> cities;

for(auto& vi : v) {
	std::string name = str_tolower(vi[1]);

	City c;

	std::istringstream iss(vi[2] + " " + vi[3]);
	iss >> c.pos.x >> c.pos.y;

	cities[name] = c;
}

@ask_user=
std::string city, citya, cityb;

@ask_city
citya = str_tolower(city);

@ask_city
cityb = str_tolower(city);

@ask_city=
while(true) {
	std::cout << "City: ";
	std::getline(std::cin, city);

	if(cities.find(str_tolower(city)) != cities.end()) {
		break;
	}

	std::cout << "Could not find '" << city << "' in the database!" << std::endl;
} 

@includes+=
#include <cmath>

@compute_distance=
const double PI = 4.0*std::atan(1.0);

auto ca = cities[citya];
auto cb = cities[cityb];

double ph1 = ca.pos.x*PI/180.0;
double ph2 = cb.pos.x*PI/180.0;

double la1 = ca.pos.y*PI/180.0;
double la2 = cb.pos.y*PI/180.0;

double s1 = std::sin((ph1 - ph2)/2.0);
double s2 = std::sin((la1 - la2)/2.0);

double h = s1*s1 + std::cos(ph1)*std::cos(ph2)*s2*s2;
const double r = 6371.0;
double d = 2*r*std::asin(std::sqrt(h));

@print_distance=
std::cout << std::endl;
std::cout << citya << " lat:"  << ca.pos.x << " lon:" << ca.pos.y << std::endl;
std::cout << cityb << " lat:"  << cb.pos.x << " lon:" << cb.pos.y << std::endl;
std::cout << std::endl;
std::cout << "Distance: " << d << " km" << std::endl;
