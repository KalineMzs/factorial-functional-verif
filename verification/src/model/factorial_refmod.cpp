#include <systemc.h>
#include "tlm.h"

using namespace std;

using namespace tlm;

struct tr {
	sc_lv<4> in_data;
	sc_logic in_valid;
	sc_lv<46> out_data;
	sc_logic out_valid;
	sc_logic out_busy;
};

#include "uvmc.h"
using namespace uvmc;
UVMC_UTILS_5(tr, in_data, in_valid, out_data, out_valid, out_busy)

SC_MODULE(factorial_refmod) {
  sc_port<tlm_get_peek_if<tr> > in;
  sc_port<tlm_put_if<tr> > out;

  SC_CTOR(factorial_refmod): in("in"), out("out") {
	SC_THREAD(p);
}

  void p() {
    
    tr tr_in, tr_out;
    while(1){
      tr_in = in->get();
		tr_out = tr_in;
      out->put(tr_out);
    }
  }
};
