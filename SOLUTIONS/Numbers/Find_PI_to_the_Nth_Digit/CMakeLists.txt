cmake_minimum_required(VERSION 3.1)
set(CMAKE_CXX_STANDARD 11)
project(app)

add_executable(app
	machin.h
	newton_test.h
	newton_test.cpp
	Ofloat.h
	main.cpp)
