#include "factorial_refmod.cpp"
#include "factorial_cpp.hpp"

int sc_main(int argc, char* argv[]) {
 
  factorial_refmod refmod_i("refmod_i");

	uvmc_connect(refmod_i.in, "foo");
	uvmc_connect(refmod_i.out, "bar");

  sc_start();
  return(0);
}
