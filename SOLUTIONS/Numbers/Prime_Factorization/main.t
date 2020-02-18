@*=
@includes

auto main() -> int
{
	@ask_user
	@prime_factorize
	@display_prime_factors

	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>
#include <cstdint>

@ask_user=
uint32_t num;
std::cout << "Enter a number: ";
std::cin >> num;

@includes+=
#include <vector>

@prime_factorize=
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

@display_prime_factors=
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
