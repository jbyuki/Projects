@*=
@includes

auto main() -> int
{
	@ask_user
	@compute_fib
	@display_result

	system("PAUSE");
	return 0;
}

@ask_user=
size_t n;
std::cout << "n: ";
std::cin >> n;

@includes=
#include "Ofloat.h"

@compute_fib=
Ofloat<1000> a[2] { 1, 1 };

int cur=0;

for(size_t i=3; i<=n; ++i) {
	cur = !cur;
	a[cur] = a[cur] + a[!cur];
}

@display_result=
std::cout << "fib(n): " << a[cur] << std::endl;
