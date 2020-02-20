#include <iostream>
#include <cstdint>

#include <array>


auto main() -> int
{
	uint64_t a;
	std::cout << "a: ";
	std::cin >> a;
	
	uint64_t b;
	std::cout << "b: ";
	std::cin >> b;
	
	std::array<uint64_t, 64> exponent;
	
	exponent[0] = a;
	for(size_t i=1; i<exponent.size(); ++i) {
		exponent[i] = exponent[i-1] * exponent[i-1];
	}
	
	uint64_t result = 1;
	
	for(uint64_t copy=b, i=0;copy > 0; copy >>= 1, i++) {
		if(copy&1) {
			result *= exponent[i];
		}
	}
	
	std::cout << "a^b: " << result << std::endl;

	system("PAUSE");
	return 0;
}

