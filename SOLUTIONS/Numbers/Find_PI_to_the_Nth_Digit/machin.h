#pragma once
#include "Ofloat.h"

#include <cstdint>


template<size_t N, size_t M>
auto computePI(int it) -> Ofloat<N, M>;


template<size_t N, size_t M>
auto computePI(int it) -> Ofloat<N, M>
{
	
	Ofloat<N, M> m1(1);
	m1 /= 5;
	
	Ofloat<N, M> x1(m1);
	
	Ofloat<N, M> m2(1);
	m2 /= 239;
	
	Ofloat<N, M> x2(m2);
	
	m1 *= m1;
	m2 *= m2;
	
	Ofloat<N, M> result;
	
	uint32_t den = 1;
	

	for(int i=0; i<it; ++i) {
		if((i&1) == 0) {
			result += x1*4/den;
			result -= x2/den;
			
		} else {
			result += x2/den;
			result -= x1*4/den;
			
		}

		den += 2;
		x1 *= m1;
		x2 *= m2;
		
	}

	result *= 4;
	return result;
}


