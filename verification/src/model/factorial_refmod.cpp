#include <systemc.h>
#include "tlm.h"
#include "factorial_cpp.hpp"

using namespace std;

using namespace tlm;

struct tr {
	int in_data;
	sc_bit in_valid;
	int out_data;
	sc_bit out_valid;
	sc_bit out_busy;
};

#include "uvmc.h"
using namespace uvmc;
UVMC_UTILS_5(tr, in_data, in_valid, out_data, out_valid, out_busy)

SC_MODULE(factorial_refmod) {
  sc_port<tlm_get_peek_if<tr> > in;
  sc_port<tlm_put_if<tr> > out;

	sc_signal<bool> clk_signal;
	sc_signal<bool> resetn_signal;
	sc_signal<int> in_data_signal;
	sc_signal<bool> in_valid_signal;

	sc_signal<int> out_data_signal;
	sc_signal<bool> out_valid_signal;
	sc_signal<bool> out_busy_signal;

 factorial_cpp child_factorial;

  SC_CTOR(factorial_refmod): in("in"), out("out"), child_factorial("child_factorial") {
	child_factorial.clk(clk_signal);
	child_factorial.resetn(resetn_signal);
	child_factorial.in_data(in_data_signal);
	child_factorial.in_valid(in_valid_signal);

	child_factorial.out_data(out_data_signal);
	child_factorial.out_valid(out_valid_signal);
	child_factorial.out_busy(out_busy_signal);

	SC_THREAD(p);
}

  void p() {
    
    tr tr_in, tr_out;

    while(1){
		tr_in = in->get();
		clk_signal = 1;
		resetn_signal = 1;
		in_data_signal = tr_in.in_data;
		in_valid_signal = tr_in.in_valid;

		child_factorial.factorial_proc();

		tr_out.out_data = out_data_signal.read();
		tr_out.out_valid = out_valid_signal.read();
		tr_out.out_busy = out_busy_signal.read();

		out->put(tr_out);

		clk_signal = 0;
    }
  }
};
