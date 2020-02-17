@desc=
"There are different methods to compute Pi."
"One of the easiest is to approximate arctan(1) using Taylor series."
"However this naive method converges too slowly."
"It is a valid method though and the series has the name 'Leibniz series'."
"A small modification of this method can be"
"done though to have a faster convergence."
"It is the one used in this program called the 'Machin Formula'."
"Pi/4 is approximated by 4*arctan(1/5)-arctan(1/239)"
"The coefficients were found empiracally so"
"that the convergence is faster."
"The correctness of the formula can be seen with"
"complex numbers in polar form where (i+5)^4/(i+239) = 2*(1+i)."

@machin.h=
#pragma once
@includes

@functions

@define_functions

@includes=
#include "Ofloat.h"

@functions=
template<size_t N, size_t M>
auto computePI(int it) -> Ofloat<N, M>;

@define_functions=
template<size_t N, size_t M>
auto computePI(int it) -> Ofloat<N, M>
{
	@init_initial_x
	@init_multipliers
	@init_result
	@init_denominator

	for(int i=0; i<it; ++i) {
		if((i&1) == 0) {
			@add_taylor_to_result
		} else {
			@sub_taylor_to_result
		}

		@update_for_next_it
	}

	@multiply_result_by_4
	return result;
}

@init_initial_x=

Ofloat<N, M> m1(1);
m1 /= 5;

Ofloat<N, M> x1(m1);

Ofloat<N, M> m2(1);
m2 /= 239;

Ofloat<N, M> x2(m2);

@init_multipliers=
m1 *= m1;
m2 *= m2;

@init_result=
Ofloat<N, M> result;

@includes+=
#include <cstdint>

@init_denominator=
uint32_t den = 1;

@add_taylor_to_result=
result += x1*4/den;
result -= x2/den;

@sub_taylor_to_result=
result += x2/den;
result -= x1*4/den;

@update_for_next_it=
den += 2;
x1 *= m1;
x2 *= m2;

@multiply_result_by_4=
result *= 4;
