@*=
@includes

auto main() -> int
{
	@ask_user
	@init_result

	switch(option) {
	case 0: {
		@compute_binary
		break; }
	case 1: {
		@compute_decimal
		break; }
	default:
		return EXIT_FAILURE;
	}

	@display_result

	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>

@ask_user=
std::cout << "Binary to decimal converter or back" << std::endl;
std::cout << std::endl;

int option = -1;

while(option < 0 || option > 1) {
	std::cout << "0 - Decimal to Binary" << std::endl;
	std::cout << "1 - Binary to Decimal" << std::endl;
	std::cout << "Option: ";
	std::cin >> option;
}

@includes+=
#include <string>

@ask_user+=
std::string input;
std::cout << "Number: ";
std::cin >> input;

@includes+=
#include <vector>
#include <cstdint>

@init_result=
std::vector<uint8_t> digits;

@includes+=
#include <sstream>

@compute_binary=
std::istringstream iss(input);
uint64_t num;
iss >> num;

while(num > 0) {
	digits.push_back((uint8_t)(num%2));
	num /= 2;
}

@compute_decimal=
uint64_t mul = 1;
uint64_t result = 0;
for(size_t i=input.size(); i>0; --i) {
	if(input[i-1] == '1') {
		result += mul;
	}
	mul *= 2;
}

while(result > 0) {
	digits.push_back((uint8_t)(result%10));
	result /= 10;
}

@display_result=
std::cout << "Result: ";
for(size_t i=digits.size(); i>0; --i) {
	std::cout << (int)digits[i-1];
}
std::cout << std::endl;
