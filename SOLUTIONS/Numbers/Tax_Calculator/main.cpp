#include <iostream>


auto main() -> int
{
	float cost;
	std::cout << "Cost: ";
	std::cin >> cost;
	
	float tax_rate;
	std::cout << "Tax Rate(%): ";
	std::cin >> tax_rate;
	
	float tax = tax_rate * cost;
	
	std::cout << "Tax: " << tax << std::endl;
	std::cout << "Tax+Cost: " << tax+cost << std::endl;

	system("PAUSE");
	return 0;
}

