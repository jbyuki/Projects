cmake_minimum_required(VERSION 3.1)
set(CMAKE_CXX_STANDARD 11)
project(app)

add_executable(app
	csv.cpp
	csv.h
	vec2.h
	string_utils.cpp
	string_utils.h
	main.cpp)
