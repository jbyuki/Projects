#include <iostream>
#include "Ofloat.h"
#include <iomanip>
#include "machin.h"


auto main() -> int
{
	// @test_ofloat
	// @newton_test
	int it;
	std::cout << "Number of iterations: ";
	std::cin >> it;
	
	int precision;
	std::cout << "Number of decimals: ";
	std::cin >> precision;
	
	std::cout << std::endl;
	
	Ofloat<256, 128> pi = computePI<256, 128>(it);
	
	std::cout << std::setprecision(precision) << "PI: " << pi << std::endl;

	system("PAUSE");
	return 0;
}

