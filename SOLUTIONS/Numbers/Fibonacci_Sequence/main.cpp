#include "Ofloat.h"


auto main() -> int
{
	size_t n;
	std::cout << "n: ";
	std::cin >> n;
	
	Ofloat<1000> a[2] { 1, 1 };
	
	int cur=0;
	
	for(size_t i=3; i<=n; ++i) {
		cur = !cur;
		a[cur] = a[cur] + a[!cur];
	}
	
	std::cout << "fib(n): " << a[cur] << std::endl;

	system("PAUSE");
	return 0;
}

