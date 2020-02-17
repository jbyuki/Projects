@*=
@includes

auto main() -> int
{
	@ask_user_for_preferences
	@compute_e
	@display_e

	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>

@ask_user_for_preferences=
size_t it;
std::cout << "Number of iterations: ";
std::cin >> it;

size_t precision;
std::cout << "Number of decimals: ";
std::cin >> precision;


@includes+=
#include "Ofloat.h"

@compute_e=
Ofloat<256, 128> result(1);

Ofloat<256, 128> rec_n(1);

for(size_t i=1; i<=it; ++i) {
	rec_n *= i;
	result += rec_n.invert();
}

@includes+=
#include <iomanip>

@display_e=
std::cout << std::setprecision(precision) << result << std::endl;
