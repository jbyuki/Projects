@*=
@includes

@check_happy_function

auto main() -> int
{
	@ask_user
	@search_for_n_happy_numbers

	system("PAUSE");
	return 0;
}

@includes=
#include <array>

@check_happy_function=
auto isHappy(int i) -> bool
{
	static std::array<bool, 10000> passage;
	passage.fill(0);

	passage[1] = true;

	while(!passage[i] || i >= 10000) {
		passage[i] = true;

		int sum = 0;
		for(int copy = i; copy > 0; copy/= 10) {
			int d = copy%10;
			sum += d*d;
		}
		i = sum;
	}

	return i==1;
}

@includes+=
#include <iostream>

@ask_user=
int n;
std::cout << "How many happy numbers: ";
std::cin >> n;

@search_for_n_happy_numbers=
int m = 0;
for(int i=1; m<n; ++i) {
	if(isHappy(i)) {
		std::cout << "Happy: " << i << std::endl;
		i++;
		m++;
	}
}
