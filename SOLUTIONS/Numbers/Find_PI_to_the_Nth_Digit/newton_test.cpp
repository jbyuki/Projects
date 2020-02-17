#include "newton_test.h"

auto newton(float D, int it) -> float
{
	float Dp = D;
	int i = 0;
	while(Dp > 1.f) {
		Dp /= 2.f;
		i++;
	}

	float x = 48.f/17.f - 32.f*Dp/17.f;

	for(int i=0; i<it; ++i) {
		std::cout << x << std::endl;
		x = x + x*(1-Dp*x);
	}

	for(;i > 0; i--) {
		x /= 2.f;
	}

	return x;
}

