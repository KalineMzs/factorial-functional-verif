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
UVMC_UTILS_5(tr, in_data, in_data, out_valid, out_valid, out_busy)

SC_MODULE(factorial_refmod) {
  sc_port<tlm_get_peek_if<tr> > in;
  sc_port<tlm_put_if<tr> > out;

  SC_CTOR(factorial_refmod): in("in"), out("out") {
		SC_THREAD(p);
		cout << "to tentando \n";
      uvmc_connect(in, "foo");
      uvmc_connect(out, "bar");
	}

  void p() {
    
    tr tr;
    while(1){
      tr = in->get();
      cout <<"refmod out_data: " <<tr.out_data <<"\n";
      cout <<"refmod out_valid: " <<tr.out_valid <<"\n";
      cout <<"refmod out_busy: " <<tr.out_busy <<"\n";
      out->put(tr);
    }
  }
};
