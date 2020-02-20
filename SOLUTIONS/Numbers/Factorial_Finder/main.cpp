#include <iostream>
#include <cstdint>

#include "Ofloat.h"


auto main() -> int
{
	uint32_t n;
	std::cout << "n: ";
	std::cin >> n;
	
	Ofloat<1000> result(1);
	
	for(uint32_t i=2; i<=n; ++i) {
		result *= i;
	}
	
	std::cout << "n!: " << result << std::endl;

	system("PAUSE");
	return 0;
}

