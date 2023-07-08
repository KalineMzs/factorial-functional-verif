#include "factorial_refmod.cpp"
#include "factorial_cpp.hpp"

int sc_main(int argc, char* argv[]) {

	factorial_refmod refmod_i("refmod_i");

	uvmc_connect(refmod_i.in, "rfm_in");
	uvmc_connect(refmod_i.out, "rfm_out");

	sc_start();
	return(0);
}