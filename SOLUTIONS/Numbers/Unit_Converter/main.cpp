#include <iostream>


auto main() -> int
{
	float number;
	std::cout << "Number: ";
	std::cin >> number;
	
	int unit;
	do {
		std::cout << "0 - Temperature" << std::endl;
		std::cout << "1 - Mass" << std::endl;
		std::cout << "Unit: ";
		std::cin >> unit;
	} while(unit < 0 || unit > 1);
	
	
	switch(unit) {
	case 0: { // temperature
		int temp;
		std::cout << "What would you convert TO?" << std::endl;
		do {
			std::cout << "0 - Celsius" << std::endl;
			std::cout << "1 - Fahrenheit" << std::endl;
			std::cout << "Unit: ";
			std::cin >> temp;
		} while(temp < 0 || temp > 1);
		
		switch(temp) {
		case 0: // Fahrenheit -> Celsius
			number = (number - 32.f)*5.f/9.f;
			std::cout << "Result: " << number << " Celsius" << std::endl;
			break;
		case 1: // Celsius -> Fahrenheit
			number = number*9.f/5.f + 32.f;
			std::cout << "Result: " << number << " Fahrenheit" << std::endl;
			break;
		}
		
		break; }
	case 1: { // mass
		int start;
		std::cout << "0 - Kilogram" << std::endl;
		std::cout << "1 - Gram" << std::endl;
		std::cout << "2 - Pound" << std::endl;
		
		std::cout << "Original Unit: ";
		std::cin >> start;
		
		int end;
		std::cout << "0 - Kilogram" << std::endl;
		std::cout << "1 - Gram" << std::endl;
		std::cout << "2 - Pound" << std::endl;
		
		std::cout << "Converted Unit: ";
		std::cin >> end;
		
		switch(start) {
		case 1: number /= 1000.f; break;
		case 2: number *= 0.453592f; break;
		}
		
		switch(end) {
		case 1: number *= 1000.f; break;
		case 2: number /= 0.453592f; break;
		}
		
		std::cout << "Result: " << number;
		switch(end) {
		case 0: std::cout << " Kilogram" << std::endl; break;
		case 1: std::cout << " Gram" << std::endl; break;
		case 2: std::cout << " Pound" << std::endl; break;
		}
		break; }
	}
	system("PAUSE");
	return 0;
}

