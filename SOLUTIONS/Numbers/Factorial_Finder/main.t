@*=
@includes

auto main() -> int
{
	@ask_user
	@compute
	@display_result

	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>
#include <cstdint>

@ask_user=
uint32_t n;
std::cout << "n: ";
std::cin >> n;

@includes+=
#include "Ofloat.h"

@compute=
Ofloat<1000> result(1);

for(uint32_t i=2; i<=n; ++i) {
	result *= i;
}

@display_result=
std::cout << "n!: " << result << std::endl;
