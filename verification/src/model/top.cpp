#include "factorial_sc.cpp"
#include "factorial_cpp.hpp"

int sc_main(int argc, char* argv[]) {

	factorial_sc sc("sc");

	uvmc_connect(sc.in, "sc_in");
	uvmc_connect(sc.out, "sc_out");

	sc_start();
	return(0);
}
