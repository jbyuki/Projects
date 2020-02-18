#include <iostream>


auto main() -> int
{
	std::cout << "Mortgage Calculator" << std::endl;
	
	float loan, equity, years, interest_rate;
	std::cout << std::endl;
	std::cout << "Loan: ";
	std::cin >> loan;
	std::cout << "Equity: ";
	std::cin >> equity;
	std::cout << "Term (years): ";
	std::cin >> years;
	
	interest_rate = -1.f;
	while(interest_rate < 0.f || interest_rate > 1.f) {
		std::cout << "Taux Interet (%): ";
		std::cin >> interest_rate;
		interest_rate /= 100.f;
	}
	
	float mon_interest = (loan-equity)*interest_rate/12.f;
	float mon_amortization = (loan-equity)/years/12.f;
	
	std::cout << "Monthly costs" << std::endl;
	std::cout << std::endl;
	std::cout << "Interest: " << mon_interest << std::endl;
	std::cout << "Amortization: " << mon_amortization << std::endl;
	std::cout << std::endl;
	std::cout << "Total: " << mon_interest+mon_amortization << std::endl;

	system("PAUSE");
	return 0;
}

