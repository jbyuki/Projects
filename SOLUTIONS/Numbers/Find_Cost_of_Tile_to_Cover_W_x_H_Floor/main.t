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
float W, H, C;
std::cout << "Compute the total of a Floor WxH." << std::endl;
std::cout << "Floor W: ";
std::cin >> W;

std::cout << "Floor H: ";
std::cin >> H;

std::cout << "Tile cost: ";
std::cin >> C;

@compute=
float T = W * H * C;

@display_result=
std::cout << "Floor Total Cost: " << T << std::endl;
