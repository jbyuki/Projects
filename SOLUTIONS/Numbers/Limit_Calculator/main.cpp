#include <string>
#include <iostream>

#include <limits>

#include "parser.h"


auto main() -> int
{
	std::string input;
	std::cout << "f(x): ";
	std::cin >> input;
	
	float start;
	std::cout << "Start: ";
	std::cin >> start;
	
	int option;
	do {
		std::cout << "0 - Constant Limit" << std::endl;
		std::cout << "1 - To Infinity (Same Sign as Start)" << std::endl;
		std::cout << "Infinity: ";
		std::cin >> option;
	} while(option < 0 || option > 1);
	
	float limit;
	switch(option) {
	case 0: std::cout << "Limit: "; std::cin >> limit; break;
	case 1: limit = std::numeric_limits<float>::infinity(); break;
	}
	
	int it;
	std::cout << "Iteration: ";
	std::cin >> it;
	
	
	Parser parser;
	auto exp = parser.process(input);
	auto px = parser.getSymbol("x");
	
	if(!px) {
		std::cout << "Please use 'x' as a variable." << std::endl;
		system("PAUSE");
		return EXIT_FAILURE;
	}
	
	*px = start;
	for(int i=0; i<it; ++i) {
		std::cout << "limit f(" << *px << "): " << exp->eval() << std::endl;
	
		if(limit == std::numeric_limits<float>::infinity()) {
			*px *= 2.f;
		} else {
			*px = (*px + limit)/2.f;
		}
	}
	system("PAUSE");
	return 0;
}

