all: main.cpp main.res vec2.h parser.cpp parser.h

main.cpp: main.t; letangle.exe main.t > main.cpp
main.res: main.rc; rc main.rc
vec2.h: vec2.t; letangle.exe vec2.t > vec2.h
parser.cpp: parser.t; letangle.exe parser.t parser.cpp > parser.cpp
parser.h: parser.t; letangle.exe parser.t parser.h > parser.h
