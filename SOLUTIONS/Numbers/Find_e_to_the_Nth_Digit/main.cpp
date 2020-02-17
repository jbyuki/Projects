#include <iostream>

#include "Ofloat.h"

#include <iomanip>


auto main() -> int
{
	size_t it;
	std::cout << "Number of iterations: ";
	std::cin >> it;
	
	size_t precision;
	std::cout << "Number of decimals: ";
	std::cin >> precision;
	
	
	Ofloat<256, 128> result(1);
	
	Ofloat<256, 128> rec_n(1);
	
	for(size_t i=1; i<=it; ++i) {
		rec_n *= i;
		result += rec_n.invert();
	}
	
	std::cout << std::setprecision(precision) << result << std::endl;

	system("PAUSE");
	return 0;
}

