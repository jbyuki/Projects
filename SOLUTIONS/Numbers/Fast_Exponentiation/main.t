@desc=
"The idea is to decompose the exponent in base-2."
"Then compute the number raised to every base-2 that's needed (number^1, number^2, number^4,...)."
"Using the base-2 decomposition, add the results from the table."

@*=
@includes

auto main() -> int
{
	@ask_user
	@compute_result
	@print_result

	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>
#include <cstdint>

@ask_user=
uint64_t a;
std::cout << "a: ";
std::cin >> a;

uint64_t b;
std::cout << "b: ";
std::cin >> b;

@includes+=
#include <array>

@compute_result=
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

@print_result=
std::cout << "a^b: " << result << std::endl;
