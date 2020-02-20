#include <iostream>


template<typename T>
struct MyComplex
{
	MyComplex(T real, T imag);
	
	auto operator+=(const MyComplex<T>& other) -> MyComplex<T>&;
	
	auto operator-=(const MyComplex<T>& other) -> MyComplex<T>&;
	
	auto operator*=(const MyComplex<T>& other) -> MyComplex<T>&;
	
	auto operator/=(const MyComplex<T>& other) -> MyComplex<T>&;
	
	auto operator+(const MyComplex<T>& other) -> MyComplex<T>;
	
	auto operator-(const MyComplex<T>& other) -> MyComplex<T>;
	
	auto operator*(const MyComplex<T>& other) -> MyComplex<T>;
	
	auto operator/(const MyComplex<T>& other) -> MyComplex<T>;
	
	T real, imag;
	
};


template<typename T>
auto operator<<(std::ostream& out, const MyComplex<T>& other) -> std::ostream&;


template<typename T>
MyComplex<T>::MyComplex(T real, T imag) :
	real(real), imag(imag)
{
}

template<typename T>
auto MyComplex<T>::operator+=(const MyComplex<T>& other) -> MyComplex<T>&
{
	real += other.real;
	imag += other.imag;
	return *this;
}

template<typename T>
auto MyComplex<T>::operator-=(const MyComplex<T>& other) -> MyComplex<T>&
{
	*this += MyComplex(-other.real, -other.imag);
	return *this;
}

template<typename T>
auto MyComplex<T>::operator*=(const MyComplex<T>& other) -> MyComplex<T>&
{
	*this = MyComplex(real*other.real-imag*other.imag, real*other.imag+imag*other.real);
	return *this;
}

template<typename T>
auto MyComplex<T>::operator/=(const MyComplex<T>& other) -> MyComplex<T>&
{
	T den = other.real*other.real + other.imag*other.imag;
	*this *= MyComplex(other.real/den, -other.imag/den);
	return *this;
}

template<typename T>
auto MyComplex<T>::operator+(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy += other;
	return copy;
}

template<typename T>
auto MyComplex<T>::operator-(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy -= other;
	return copy;
}

template<typename T>
auto MyComplex<T>::operator*(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy *= other;
	return copy;
}

template<typename T>
auto MyComplex<T>::operator/(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy /= other;
	return copy;
}


template<typename T>
auto operator<<(std::ostream& out, const MyComplex<T>& other) -> std::ostream&
{
	out << other.real << " + " << other.imag << "j";
	return out;
}


auto main() -> int
{
	float r1, i1;
	float r2, i2;
	
	std::cout << "Real(A): ";
	std::cin >> r1;
	
	std::cout << "Imag(A): ";
	std::cin >> i1;
	
	std::cout << "Real(B): ";
	std::cin >> r2;
	
	std::cout << "Imag(B): ";
	std::cin >> i2;
	
	MyComplex<float> A(r1, i1), B(r2, i2);
	std::cout << "A + B: " << A+B << std::endl;
	std::cout << "A - B: " << A-B << std::endl;
	std::cout << "A * B: " << A*B << std::endl;
	std::cout << "A / B: " << A/B << std::endl;

	system("PAUSE");
	return 0;
}

