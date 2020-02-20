#include <iostream>

#include <random>
#include <array>


auto main() -> int
{
	int num;
	std::cout << "How many Coin Flips: ";
	std::cin >> num;
	
	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_int_distribution<> dis(0, 1); // 0: head, 1: tail
	
	std::array<int, 2> count;
	count.fill(0);
	
	for(int i=0; i<num; ++i) {
		count[dis(gen)]++;
	}
	
	std::cout << "Heads: " << count[0] << std::endl;
	std::cout << "Tails: " << count[1] << std::endl;

	system("PAUSE");
	return 0;
}

