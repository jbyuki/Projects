@desc=
"A limit finder for a mathemtical expression."
"It supports basic operations, basic functions."
"The variable should be denoted by x."
"It needs a start value and an end value."
"The algorithm is by bisection approach the value."

@*=
@includes

auto main() -> int
{
	@ask_user
	@parse_expression
	@approach_expression
	system("PAUSE");
	return 0;
}

@includes=
#include <string>
#include <iostream>

@ask_user=
@ask_expression
@ask_limits
@ask_iteration

@ask_expression=
std::string input;
std::cout << "f(x): ";
std::cin >> input;

@includes+=
#include <limits>

@ask_limits=
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

@ask_iteration=
int it;
std::cout << "Iteration: ";
std::cin >> it;

@includes+=
#include "parser.h"

@parse_expression=
Parser parser;
auto exp = parser.process(input);
auto px = parser.getSymbol("x");

if(!px) {
	std::cout << "Please use 'x' as a variable." << std::endl;
	system("PAUSE");
	return EXIT_FAILURE;
}

@approach_expression=
*px = start;
for(int i=0; i<it; ++i) {
	std::cout << "limit f(" << *px << "): " << exp->eval() << std::endl;

	if(limit == std::numeric_limits<float>::infinity()) {
		*px *= 2.f;
	} else {
		*px = (*px + limit)/2.f;
	}
}
