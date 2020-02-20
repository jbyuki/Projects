@*=
#pragma once

template<typename T>
struct Vec2
{
	@member_variables
	@methods
};

@aliases

@member_variables=
T x, y;

@methods=
Vec2(T x = static_cast<T>(0), T y = static_cast<T>(0)) : x(x), y(y)
{
}

@aliases=
using Vec2i = Vec2<int>;
using Vec2f = Vec2<float>;
using Vec2d = Vec2<double>;
