#include <iostream>
#include <cstdint>
#include <vector>


auto main() -> int
{
	uint64_t number;
	std::cout << "Credit Card Number: ";
	std::cin >> number;
	
	std::vector<uint64_t> digits;
	uint64_t sum = 0;
	
	for(size_t i=0; number > 0; ++i, number/=10) {
		uint64_t digit = number%10;
		if(i&1) {
			digit *= 2;
			if(digit > 9) {
				digit -= 9;
			}
		}
		sum += digit;
	}
	
	bool valid = (sum%10) == 0;
	
	std::cout << "Number is " << (valid ? "Valid": "Invalid") << "!" << std::endl;
	
	if(!valid) {
		std::cout << "Mod 10: " << sum%10 << std::endl;
	}

	system("PAUSE");
	return 0;
}

