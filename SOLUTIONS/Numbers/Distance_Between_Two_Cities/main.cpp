#include "csv.h"
#include <vector>
#include <string>
#include <fstream>
#include <iostream>

#include "vec2.h"

#include <sstream>
#include <map>
#include "string_utils.h"

#include <cmath>


struct City
{
	Vec2d pos;
};


auto main() -> int
{
	std::vector<std::vector<std::string>> v;
	{
		std::ifstream in("..\\worldcities.csv");
		if(!in.is_open()) {
			std::cout << "ERROR: Could not open worldcities.csv" << std::endl;
			return EXIT_FAILURE;
		}
	
		readCSV(in, v);
	}
	
	v.erase(v.begin());
	
	std::map<std::string, City> cities;
	
	for(auto& vi : v) {
		std::string name = str_tolower(vi[1]);
	
		City c;
	
		std::istringstream iss(vi[2] + " " + vi[3]);
		iss >> c.pos.x >> c.pos.y;
	
		cities[name] = c;
	}
	

	std::string city, citya, cityb;
	
	while(true) {
		std::cout << "City: ";
		std::getline(std::cin, city);
	
		if(cities.find(str_tolower(city)) != cities.end()) {
			break;
		}
	
		std::cout << "Could not find '" << city << "' in the database!" << std::endl;
	} 
	
	citya = str_tolower(city);
	
	while(true) {
		std::cout << "City: ";
		std::getline(std::cin, city);
	
		if(cities.find(str_tolower(city)) != cities.end()) {
			break;
		}
	
		std::cout << "Could not find '" << city << "' in the database!" << std::endl;
	} 
	
	cityb = str_tolower(city);
	
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
	
	std::cout << std::endl;
	std::cout << citya << " lat:"  << ca.pos.x << " lon:" << ca.pos.y << std::endl;
	std::cout << cityb << " lat:"  << cb.pos.x << " lon:" << cb.pos.y << std::endl;
	std::cout << std::endl;
	std::cout << "Distance: " << d << " km" << std::endl;

	system("PAUSE");
	return 0;
}

