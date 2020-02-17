#pragma once
#include <array>
#include <cstdint>

#include <iostream>
#include <vector>

#include <algorithm>

#include <cmath>


template<size_t N, size_t M=0>
struct Ofloat
{
	std::array<uint32_t, N> data;
	
	Ofloat(uint32_t n = 0);
	
	auto operator+=(const Ofloat<N,M>& other) -> Ofloat&;
	
	auto operator+(const Ofloat<N,M>& other) -> Ofloat;
	
	auto operator-=(const Ofloat<N,M>& other) -> Ofloat&;
	
	auto operator-(const Ofloat<N,M>& other) -> Ofloat;
	
	auto operator*=(uint32_t other) -> void;
	
	auto div(uint32_t other) -> uint32_t;
	
	auto is_zero() -> bool;
	
	auto lshift(size_t m=1) -> void;
	
	auto rshift(size_t m=1) -> void;
	
	auto operator*=(const Ofloat<N, M>& other) -> Ofloat<N, M>&;
	
	auto operator*(const Ofloat<N, M>& other) -> Ofloat<N, M>;
	
	auto leading_one() -> size_t;
	
	auto operator>>=(size_t n) -> Ofloat<N, M>&;
	
	auto operator<<=(size_t n) -> Ofloat<N, M>&;
	
	auto operator/=(uint32_t other) -> Ofloat<N, M>&;
	
	auto invert() -> Ofloat<N, M>;
	
	auto operator/(uint32_t other) -> Ofloat<N, M>;
	
	auto operator*(uint32_t other) -> Ofloat<N, M>;
	
};

template<size_t N, size_t M>
Ofloat<N,M>::Ofloat(uint32_t n = 0)
{
	data.fill(0);
	data[M] = n;
}

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

template<size_t N, size_t M>
auto Ofloat<N,M>::operator+(const Ofloat<N,M>& other) -> Ofloat
{
	Ofloat<N,M> copy(*this);
	copy += other;
	return copy;
}

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

template<size_t N, size_t M>
auto Ofloat<N,M>::operator-(const Ofloat<N,M>& other) -> Ofloat
{
	Ofloat<N,M> copy(*this);
	copy -= other;
	return copy;
}

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

template<size_t N, size_t M>
auto Ofloat<N, M>::operator*(const Ofloat<N, M>& other) -> Ofloat<N, M>
{
	Ofloat<N, M> copy(*this);
	copy *= other;
	return copy;
}


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

template<size_t N, size_t M>
auto Ofloat<N, M>::operator>>=(size_t n) -> Ofloat<N, M>&
{
	lshift(n/32);
	
	size_t n2 = n%32;
	if(n2 > 0) {
		for(size_t i=0; i<N; ++i) {
			uint32_t up = i+1 < N ? (data[i+1]&((1<<n2)-1)) << (32-n2) : 0;
			data[i] = up | (data[i] >> n2);
		}
	}
	

	return *this;
}

template<size_t N, size_t M>
auto Ofloat<N, M>::operator<<=(size_t n) -> Ofloat<N, M>&
{
	rshift(n/32);
	
	size_t n2 = n%32;
	if(n2 > 0) {
		for(size_t i=N; i>0; --i) {
			uint32_t down = i > 1 ? (data[i-2] >> (32-n2)) : 0;
			data[i-1] = (data[i-1] << n2) | down;
		}
	}
	

	return *this;
}

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

template<size_t N, size_t M>
auto Ofloat<N, M>::operator/(uint32_t other) -> Ofloat<N, M>
{
	Ofloat<N, M> copy(*this);
	copy /= other;
	return copy;
}

template<size_t N, size_t M>
auto Ofloat<N, M>::operator*(uint32_t other) -> Ofloat<N, M>
{
	Ofloat<N, M> copy(*this);
	copy *= other;
	return copy;
}
template<size_t N, size_t M>
auto operator<<(std::ostream& out, const Ofloat<N,M>& o) -> std::ostream&
{
	Ofloat<N,M> copy(o);

	size_t p = M > 0 ? (size_t)out.precision() : 0;

	for(size_t i=0; i<p; ++i) {
		copy *= 10;
	}
	copy.lshift(M);
	
	
	std::vector<uint8_t> digits;
	
	while(!copy.is_zero()) {
		uint32_t rest = copy.div(10);
		digits.push_back(rest);
	}
	
	if(digits.size() == 0) {
		digits.push_back(0);
	}
	
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
	

	return out;
}


