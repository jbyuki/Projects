@Ofloat.h=
#pragma once
@includes

template<size_t N, size_t M=0>
struct Ofloat
{
	@member_variables
	@methods
};

@define_methods
@io_function

@includes=
#include <array>
#include <cstdint>

@member_variables=
std::array<uint32_t, N> data;

@methods=
Ofloat(uint32_t n = 0);

@define_methods=
template<size_t N, size_t M>
Ofloat<N,M>::Ofloat(uint32_t n = 0)
{
	data.fill(0);
	data[M] = n;
}

@methods+=
auto operator+=(const Ofloat<N,M>& other) -> Ofloat&;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N,M>::operator+=(const Ofloat<N,M>& other) -> Ofloat&
{
	uint64_t carry = 0;
	size_t i;
	for(i=0; i<N; ++i) {
		uint64_t result = (uint64_t)data[i] + (uint64_t)other.data[i] + carry;
		data[i] = (uint32_t)(result&0xFFFFFFFF);
		carry = result >> 32;
	}

	return *this;
}

@methods+=
auto operator+(const Ofloat<N,M>& other) -> Ofloat;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N,M>::operator+(const Ofloat<N,M>& other) -> Ofloat
{
	Ofloat<N,M> copy(*this);
	copy += other;
	return copy;
}

@methods+=
auto operator-=(const Ofloat<N,M>& other) -> Ofloat&;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N,M>::operator-=(const Ofloat<N,M>& other) -> Ofloat&
{
	uint64_t carry = 1;
	size_t i;
	for(i=0; i<N; ++i) {
		uint64_t result = (uint64_t)data[i] + (uint64_t)(~other.data[i]) + carry;
		data[i] = (uint32_t)(result&0xFFFFFFFF);
		carry = result >> 32;
	}

	return *this;
}

@methods+=
auto operator-(const Ofloat<N,M>& other) -> Ofloat;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N,M>::operator-(const Ofloat<N,M>& other) -> Ofloat
{
	Ofloat<N,M> copy(*this);
	copy -= other;
	return copy;
}

@methods+=
auto operator*=(uint32_t other) -> void;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N,M>::operator*=(uint32_t other) -> void
{
	uint64_t carry = 0;
	size_t i;
	for(i=0;i<N; ++i) {
		uint64_t result = (uint64_t)data[i]*(uint64_t)other + carry;
		data[i] = (uint32_t)(result&0xFFFFFFFF);
		carry = result >> 32;
	}
}

@methods+=
auto div(uint32_t other) -> uint32_t;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N,M>::div(uint32_t other) -> uint32_t
{
	uint64_t rest = 0;
	for(size_t i=N; i>0; --i) {
		uint64_t result = ((rest<<32)+(uint64_t)data[i-1])/other;
		rest = ((rest<<32)+(uint64_t)data[i-1])%other;
		data[i-1] = (uint32_t)result;
	}
	return (uint32_t)rest;
}

@methods+=
auto is_zero() -> bool;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N,M>::is_zero() -> bool
{
	for(int i=0; i<N; ++i) {
		if(data[i] != 0) {
			return false;
		}
	}

	return true;
}

@includes+=
#include <iostream>
#include <vector>

@io_function=
template<size_t N, size_t M>
auto operator<<(std::ostream& out, const Ofloat<N,M>& o) -> std::ostream&
{
	Ofloat<N,M> copy(o);

	size_t p = M > 0 ? (size_t)out.precision() : 0;

	@shift_decimal_places_and_discard_rest
	@compute_digits
	@print_digits

	return out;
}

@shift_decimal_places_and_discard_rest=
for(size_t i=0; i<p; ++i) {
	copy *= 10;
}
copy.lshift(M);


@compute_digits=
std::vector<uint8_t> digits;

while(!copy.is_zero()) {
	uint32_t rest = copy.div(10);
	digits.push_back(rest);
}

if(digits.size() == 0) {
	digits.push_back(0);
}

@print_digits=
for(size_t i=digits.size(); i>p; --i) {
	out << (int)digits[i-1];
}

if(digits.size() <= p) {
	out << "0";
}

if(p > 0) {
	out << ".";
}

for(size_t i=p; i>0; --i) {
	if(i > digits.size()) {
		out << "0";
	} else {
		out << (int)digits[i-1];
	}
}

@methods+=
auto lshift(size_t m=1) -> void;

@includes+=
#include <algorithm>

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::lshift(size_t m) -> void
{
	if(m == 0) 
		return;

	for(size_t i = 0; i < N-1; ++i) {
		if(i+m >= N) {
			break;
		}
		data[i] = data[i+m];
	}

	for(size_t i=0; i<m; ++i) {
		data[N-1-i] = 0;
	}
}

@methods+=
auto rshift(size_t m=1) -> void;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::rshift(size_t m) -> void
{
	if(m == 0) 
		return;

	for(size_t i = N-1;; --i) {
		if(i < m) {
			break;
		}
		data[i] = data[i-m];
	}

	for(size_t i=0; i<m; ++i) {
		data[i] = 0;
	}
}

@methods+=
auto operator*=(const Ofloat<N, M>& other) -> Ofloat<N, M>&;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::operator*=(const Ofloat<N, M>& other) -> Ofloat<N, M>&
{
	static Ofloat<N, M> result;
	result.data.fill(0);

	for(size_t i=0; i<N; ++i) {
		uint64_t carry = 0;
		for(size_t j=0; j<N; ++j) {
			if(i+j >= N+M) {
				break;
			}

			uint64_t mul = (uint64_t)data[i] * (uint64_t)other.data[j] + (carry & 0xFFFFFFFF);
			uint64_t sum = (mul & 0xFFFFFFFF) + (i+j >= M ? (uint64_t)result.data[i+j-M] : 0);
			if(i+j >= M) {
				result.data[i+j-M] = (uint32_t)(sum & 0xFFFFFFFF);
			}
			carry = (mul >> 32) + (sum >> 32) + (carry >> 32);
		}
	}

	std::copy(result.data.begin(), result.data.begin()+N, data.begin());

	return *this;
}

@methods+=
auto operator*(const Ofloat<N, M>& other) -> Ofloat<N, M>;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::operator*(const Ofloat<N, M>& other) -> Ofloat<N, M>
{
	Ofloat<N, M> copy(*this);
	copy *= other;
	return copy;
}


@methods+=
auto leading_one() -> size_t;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::leading_one() -> size_t
{
	size_t i, j=0;
	for(i=N; i>0; --i) {
		if(data[i-1] == 0) {
			continue;
		}

		for(uint32_t copy = data[i-1]; copy > 1; copy >>= 1, j++);
		break;
	}

	if(i == 0) {
		return N*32;
	}

	return (i-1)*32 + j;
}

@methods+=
auto operator>>=(size_t n) -> Ofloat<N, M>&;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::operator>>=(size_t n) -> Ofloat<N, M>&
{
	@left_shift_uint32_by_uint32
	@left_shift_byte_by_byte

	return *this;
}

@methods+=
auto operator<<=(size_t n) -> Ofloat<N, M>&;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::operator<<=(size_t n) -> Ofloat<N, M>&
{
	@right_shift_uint32_by_uint32
	@right_shift_byte_by_byte

	return *this;
}

@left_shift_uint32_by_uint32=
lshift(n/32);

@left_shift_byte_by_byte=
size_t n2 = n%32;
if(n2 > 0) {
	for(size_t i=0; i<N; ++i) {
		uint32_t up = i+1 < N ? (data[i+1]&((1<<n2)-1)) << (32-n2) : 0;
		data[i] = up | (data[i] >> n2);
	}
}

@right_shift_uint32_by_uint32=
rshift(n/32);

@right_shift_byte_by_byte=
size_t n2 = n%32;
if(n2 > 0) {
	for(size_t i=N; i>0; --i) {
		uint32_t down = i > 1 ? (data[i-2] >> (32-n2)) : 0;
		data[i-1] = (data[i-1] << n2) | down;
	}
}

@methods+=
auto operator/=(uint32_t other) -> Ofloat<N, M>&;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::operator/=(uint32_t other) -> Ofloat<N, M>&
{
	uint64_t rest = 0;
	for(size_t i=N; i>0; --i) {
		uint64_t q = ((uint64_t)data[i-1]+rest)/(uint64_t)other;
		rest = (((uint64_t)data[i-1]+rest)%(uint64_t)other) << 32;
		data[i-1] = (uint32_t)q;
	}

	return *this;
}


@methods+=
auto invert() -> Ofloat<N, M>;

@includes+=
#include <cmath>

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::invert() -> Ofloat<N, M>
{
	size_t l = leading_one()+1 - 32*M;

	Ofloat<N, M> D(*this);

	D >>= l;

	Ofloat<N, M> X(48);
	X -= D*32;
	X /= 17;

	int it = (int)std::ceil(std::log2((M*32+1)/std::log2(17.0)));

	for(int i=0; i<it; ++i) {
		X = X*2 - D*X*X;
	}

	X >>= l;
	return X;
}

@methods+=
auto operator/(uint32_t other) -> Ofloat<N, M>;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::operator/(uint32_t other) -> Ofloat<N, M>
{
	Ofloat<N, M> copy(*this);
	copy /= other;
	return copy;
}

@methods+=
auto operator*(uint32_t other) -> Ofloat<N, M>;

@define_methods+=
template<size_t N, size_t M>
auto Ofloat<N, M>::operator*(uint32_t other) -> Ofloat<N, M>
{
	Ofloat<N, M> copy(*this);
	copy *= other;
	return copy;
}
