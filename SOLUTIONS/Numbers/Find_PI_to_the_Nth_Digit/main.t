@desc=
"Computing the digits of PI"

@*=
@includes

auto main() -> int
{
	// @test_ofloat
	// @newton_test
	@compute_pi

	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>
#include "Ofloat.h"
#include <iomanip>
#include "machin.h"

@compute_pi=
int it;
std::cout << "Number of iterations: ";
std::cin >> it;

int precision;
std::cout << "Number of decimals: ";
std::cin >> precision;

std::cout << std::endl;

Ofloat<256, 128> pi = computePI<256, 128>(it);

std::cout << std::setprecision(precision) << "PI: " << pi << std::endl;
