#include <iostream>


auto main() -> int
{
	float cost;
	std::cout << "Cost: ";
	std::cin >> cost;
	
	float amount;
	std::cout << "Amount given: ";
	std::cin >> amount;
	
	float change = amount - cost;
	
	int nq=0, nd=0, nn=0, np=0;
	float val;
	
	val = 0.25f;
	while(change >= val) {
		nq++;
		change -= val;
	}
	
	val = 0.01f;
	while(change >= val) {
		nd++;
		change -= val;
	}
	
	val = 0.05f;
	while(change >= val) {
		nn++;
		change -= val;
	}
	
	val = 0.01f;
	while(change >= val) {
		np++;
		change -= val;
	}
	
	std::cout << "Change: " << amount - cost << std::endl;
	
	std::cout << "Number of quarters: " << nq << std::endl;
	std::cout << "Number of dimes: " << nd << std::endl;
	std::cout << "Number of nickels: " << nn << std::endl;
	std::cout << "Number of pennies: " << np << std::endl;

	system("PAUSE");
	return 0;
}

