@*=
@includes

@complex_struct

@complex_io_function

@define_complex_methods

auto main() -> int
{
	@ask_user
	@print_results

	system("PAUSE");
	return 0;
}

@complex_struct=
template<typename T>
struct MyComplex
{
	@methods
	@member_variables
};

@member_variables=
T real, imag;

@methods=
MyComplex(T real, T imag);

@define_complex_methods=
template<typename T>
MyComplex<T>::MyComplex(T real, T imag) :
	real(real), imag(imag)
{
}

@methods+=
auto operator+=(const MyComplex<T>& other) -> MyComplex<T>&;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator+=(const MyComplex<T>& other) -> MyComplex<T>&
{
	real += other.real;
	imag += other.imag;
	return *this;
}

@methods+=
auto operator-=(const MyComplex<T>& other) -> MyComplex<T>&;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator-=(const MyComplex<T>& other) -> MyComplex<T>&
{
	*this += MyComplex(-other.real, -other.imag);
	return *this;
}

@methods+=
auto operator*=(const MyComplex<T>& other) -> MyComplex<T>&;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator*=(const MyComplex<T>& other) -> MyComplex<T>&
{
	*this = MyComplex(real*other.real-imag*other.imag, real*other.imag+imag*other.real);
	return *this;
}

@methods+=
auto operator/=(const MyComplex<T>& other) -> MyComplex<T>&;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator/=(const MyComplex<T>& other) -> MyComplex<T>&
{
	T den = other.real*other.real + other.imag*other.imag;
	*this *= MyComplex(other.real/den, -other.imag/den);
	return *this;
}

@methods+=
auto operator+(const MyComplex<T>& other) -> MyComplex<T>;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator+(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy += other;
	return copy;
}

@methods+=
auto operator-(const MyComplex<T>& other) -> MyComplex<T>;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator-(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy -= other;
	return copy;
}

@methods+=
auto operator*(const MyComplex<T>& other) -> MyComplex<T>;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator*(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy *= other;
	return copy;
}

@methods+=
auto operator/(const MyComplex<T>& other) -> MyComplex<T>;

@define_complex_methods+=
template<typename T>
auto MyComplex<T>::operator/(const MyComplex<T>& other) -> MyComplex<T>
{
	MyComplex<T> copy(*this);
	copy /= other;
	return copy;
}


@includes=
#include <iostream>

@complex_io_function=
template<typename T>
auto operator<<(std::ostream& out, const MyComplex<T>& other) -> std::ostream&;

@define_complex_methods+=
template<typename T>
auto operator<<(std::ostream& out, const MyComplex<T>& other) -> std::ostream&
{
	out << other.real << " + " << other.imag << "i";
	return out;
}

@ask_user=
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

@print_results=
MyComplex<float> A(r1, i1), B(r2, i2);
std::cout << "A + B: " << A+B << std::endl;
std::cout << "A - B: " << A-B << std::endl;
std::cout << "A * B: " << A*B << std::endl;
std::cout << "A / B: " << A/B << std::endl;
