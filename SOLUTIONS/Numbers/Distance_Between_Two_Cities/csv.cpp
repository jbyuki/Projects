#include "csv.h"

auto readCSV(std::istream& in, std::vector<std::vector<std::string>>& v) -> void
{
	std::string line;
	while(std::getline(in, line)) {
		std::vector<std::string> vi;
		
		size_t s = 0, i = 0;
		while(s+i < line.size()) {
			if(line[s+i] == ',') {
				vi.push_back(line.substr(s, i));
				s += i+1;
				i = 0;
			} else {
				i++;
			}
		}
		
		if(i > 0) {
			vi.push_back(line.substr(s, i));
		}
		
		for(auto& vii : vi) {
			vii = vii.substr(1, vii.size()-2);
		}
		
		v.push_back(vi);
	}
}


