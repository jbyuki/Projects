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

@ask_user=
float cost;
std::cout << "Cost: ";
std::cin >> cost;

float tax_rate;
std::cout << "Tax Rate(%): ";
std::cin >> tax_rate;

@compute=
float tax = tax_rate * cost;

@display_result=
std::cout << "Tax: " << tax << std::endl;
std::cout << "Tax+Cost: " << tax+cost << std::endl;
