@*=
@includes

auto main() -> int
{
	@ask_user_number
	@ask_unit
	switch(unit) {
	case 0: { // temperature
		@ask_user_destination_temperature
		@convert_temperature
		break; }
	case 1: { // mass
		@ask_user_start_mass
		@ask_user_destination_mass
		@convert_mass
		@print_result_mass
		break; }
	}
	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>

@ask_user_number=
float number;
std::cout << "Number: ";
std::cin >> number;

@ask_unit=
int unit;
do {
	std::cout << "0 - Temperature" << std::endl;
	std::cout << "1 - Mass" << std::endl;
	std::cout << "Unit: ";
	std::cin >> unit;
} while(unit < 0 || unit > 1);


@ask_user_destination_temperature=
int temp;
std::cout << "What would you convert TO?" << std::endl;
do {
	std::cout << "0 - Celsius" << std::endl;
	std::cout << "1 - Fahrenheit" << std::endl;
	std::cout << "Unit: ";
	std::cin >> temp;
} while(temp < 0 || temp > 1);

@convert_temperature=
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

@ask_user_start_mass=
int start;
@print_masses
std::cout << "Original Unit: ";
std::cin >> start;

@ask_user_destination_mass=
int end;
@print_masses
std::cout << "Converted Unit: ";
std::cin >> end;

@print_masses=
std::cout << "0 - Kilogram" << std::endl;
std::cout << "1 - Gram" << std::endl;
std::cout << "2 - Pound" << std::endl;

@convert_mass=
switch(start) {
case 1: number /= 1000.f; break;
case 2: number *= 0.453592f; break;
}

switch(end) {
case 1: number *= 1000.f; break;
case 2: number /= 0.453592f; break;
}

@print_result_mass=
std::cout << "Result: " << number;
switch(end) {
case 0: std::cout << " Kilogram" << std::endl; break;
case 1: std::cout << " Gram" << std::endl; break;
case 2: std::cout << " Pound" << std::endl; break;
}
