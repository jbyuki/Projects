@*=
@includes

@is_prime

auto main() -> int
{
	@init_first_prime
	while(true) {
		@display_next_prime
		@ask_user_to_continue
		@find_next_prime
	}


	return 0;
}

@includes=
#include <cstdint>

@is_prime=
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

@init_first_prime=
uint32_t n = 2;

@includes+=
#include <iostream>

@display_next_prime=
std::cout << n << std::endl;

@includes+=
#include <string>

@ask_user_to_continue=
std::string response = "";
while(response != "y" && response != "n") {
	std::cout << "Display next prime (y/n): ";
	std::cin >> response;
}

if(response == "n") {
	break;
}

@find_next_prime=
while(!is_prime(++n));
