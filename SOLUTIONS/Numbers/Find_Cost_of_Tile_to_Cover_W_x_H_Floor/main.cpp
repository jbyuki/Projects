#include <iostream>


auto main() -> int
{
	float W, H, C;
	std::cout << "Compute the total of a Floor WxH." << std::endl;
	std::cout << "Floor W: ";
	std::cin >> W;
	
	std::cout << "Floor H: ";
	std::cin >> H;
	
	std::cout << "Tile cost: ";
	std::cin >> C;
	
	float T = W * H * C;
	
	std::cout << "Floor Total Cost: " << T << std::endl;

	system("PAUSE");
	return 0;
}

