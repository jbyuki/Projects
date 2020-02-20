@*=
@includes

@spell_out_function

auto main() -> int
{
	@ask_user
	@spell_out_name

	system("PAUSE");
	return 0;
}

@includes=
#include <iostream>

@ask_user=
int number;
std::cout << "Number: ";
std::cin >> number;

@spell_out_function=
auto spellOut(int n) -> void
{
	if(n >= 1000000) {
		std::cout << "Not supported!" << std::endl;
	} else if(n >= 1000) {
		spellOut(n/1000);
		std::cout << " Thousand";
		spellOut(n%1000);
	} else if(n >= 100) {
		spellOut(n/100);
		std::cout << " Hundred";
		spellOut(n%100);
	} else if(n >= 20) {
		switch(n/10) {
			case 9: std::cout << " Ninety"; break;
			case 8: std::cout << " Eighty"; break;
			case 7: std::cout << " Seventy"; break;
			case 6: std::cout << " Sixty"; break;
			case 5: std::cout << " Fifty"; break;
			case 4: std::cout << " Fourty"; break;
			case 3: std::cout << " Thirty"; break;
			case 2: std::cout << " Twenty"; break;
		}
		spellOut(n%10);
	} else if(n > 0) {
		switch(n) {
			case 19: std::cout << " Nineteen"; break;
			case 18: std::cout << " Eighteen"; break;
			case 17: std::cout << " Seventeen"; break;
			case 16: std::cout << " Sixteen"; break;
			case 15: std::cout << " Fifteen"; break;
			case 14: std::cout << " Fourteen"; break;
			case 13: std::cout << " Thirteen"; break;
			case 12: std::cout << " Twelve"; break;
			case 11: std::cout << " Eleven"; break;
			case 10: std::cout << " Ten"; break;
			case 9: std::cout << " Nine"; break;
			case 8: std::cout << " Eight"; break;
			case 7: std::cout << " Seven"; break;
			case 6: std::cout << " Six"; break;
			case 5: std::cout << " Five"; break;
			case 4: std::cout << " Four"; break;
			case 3: std::cout << " Three"; break;
			case 2: std::cout << " Two"; break;
			case 1: std::cout << " One"; break;
		}
	}
}

@spell_out_name=
std::cout << "English Name: ";
spellOut(number);
std::cout << std::endl;
