#include <systemc.h>
#include "tlm.h"
#include "factorial_cpp.hpp"

using namespace std;

using namespace tlm;

struct tr {
	int in_data;
	bool in_valid;
	int out_data;
	bool out_valid;
	bool out_busy;
};

#include "uvmc.h"
using namespace uvmc;
UVMC_UTILS_5(tr, in_data, in_valid, out_data, out_valid, out_busy)

SC_MODULE(factorial_refmod) {
  sc_port<tlm_get_peek_if<tr> > in;
  sc_port<tlm_put_if<tr> > out;

	sc_signal<bool> clk_sig;
	sc_signal<bool> resetn_sig;
	sc_signal<int> in_data_sig;
	sc_signal<bool> in_valid_sig;

	sc_signal<int> out_data_sig;
	sc_signal<bool> out_valid_sig;
	sc_signal<bool> out_busy_sig;

	factorial_cpp factorial;

  SC_CTOR(factorial_refmod): in("in"), out("out"), factorial("factorial") {
		factorial.clk(clk_sig);
		factorial.resetn(resetn_sig);
		factorial.in_data(in_data_sig);
		factorial.in_valid(in_valid_sig);

		factorial.out_data(out_data_sig);
		factorial.out_valid(out_valid_sig);
		factorial.out_busy(out_busy_sig);
		
		SC_THREAD(p);
	}

  void p() {
    
    tr tr_in, tr_out;

    while(1){
			clk_sig = 0;
			tr_in = in->get();

			in_valid_sig = 1;
			in_data_sig = tr_in.in_data;
			clk_sig = 1;

			tr_out.out_valid = out_valid_sig.read();
			tr_out.out_busy = out_busy_sig.read();
			tr_out.out_data = static_cast<unsigned int>(out_data_sig.read());

			out->put(tr_out);
    }
  }
};
