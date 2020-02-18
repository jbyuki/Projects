#include <cstdint>

#include <iostream>

#include <string>


auto is_prime(uint32_t n) -> bool
{
	uint32_t p = 2;
	while(p*p <= n) {
		if(n%p == 0) {
			return false;
		}
		p++;
	}

	return true;
}


auto main() -> int
{
	uint32_t n = 2;
	
	while(true) {
		std::cout << n << std::endl;
		
		std::string response = "";
		while(response != "y" && response != "n") {
			std::cout << "Display next prime (y/n): ";
			std::cin >> response;
		}
		
		if(response == "n") {
			break;
		}
		
		while(!is_prime(++n));
	}


	return 0;
}

