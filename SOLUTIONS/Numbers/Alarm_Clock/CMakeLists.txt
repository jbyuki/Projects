cmake_minimum_required(VERSION 3.1)
set(CMAKE_CXX_STANDARD 11)
project(app)

add_executable(app WIN32
	main.cpp)

target_link_libraries(app ws2_32 winmm)
