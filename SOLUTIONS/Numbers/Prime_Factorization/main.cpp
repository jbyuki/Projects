#include <iostream>
#include <cstdint>

#include <vector>


auto main() -> int
{
	uint32_t num;
	std::cout << "Enter a number: ";
	std::cin >> num;
	
	uint32_t p = 2;
	std::vector<uint32_t> factors;
	while(num > 1 && p <= num) {
		if(num%p == 0) {
			factors.push_back(p);
			num /= p;
		} else {
			p++;
		}
	}
	
	std::cout << std::endl;
	if(factors.size() > 1) {
		std::cout << "Factors" << std::endl;
		for(uint32_t p : factors) {
			std::cout << p << " ";
		}
		std::cout << std::endl;
	} else {
		std::cout << "It is a prime number!" << std::endl;
	}

	system("PAUSE");
	return 0;
}

