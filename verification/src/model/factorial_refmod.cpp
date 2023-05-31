#include <systemc.h>
#include "tlm.h"
#include "factorial_cpp.hpp"

using namespace std;

using namespace tlm;

class tr {
public:
	sc_uint<3> in_data;
	bool in_valid;
	sc_uint<16> out_data;
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

			clk_sig = 0;
    while(1){
//			cout << " \n antes: tr_in.in_valid: " << tr_in.in_valid << " data: " << tr_in.in_data << "\n";
			in->get(tr_in);
			cout << " dps de get tr_in.in_valid: " << tr_in.in_valid << " data: " << tr_in.in_data << "\n";
			resetn_sig = 1;
			//cout << " dps de reset tr_in.in_valid: " << tr_in.in_valid << "\n";

			in_data_sig = tr_in.in_data;
			//cout << " dps de in_data tr_in.in_valid: " << tr_in.in_valid << "\n";
			in_valid_sig = tr_in.in_valid;
			//cout << " dps de in_valid tr_in.in_valid: " << tr_in.in_valid << "\n";
			clk_sig = 1;
			//cout << " dps de clk tr_in.in_valid: " << tr_in.in_valid << "\n";

//			tr_out.in_valid = tr_in.in_valid;
			//cout << " dps de tr_out.in_valid tr_in.in_valid: " << tr_in.in_valid << "\n";
//			tr_out.out_valid = out_valid_sig.read();
			//cout << " dps de tr_out.out_valid tr_in.in_valid: " << tr_in.in_valid << "\n";
//			tr_out.out_busy = out_busy_sig.read();
			//cout << " dps de tr_out.out_busy tr_in.in_valid: " << tr_in.in_valid << "\n";
//			tr_out.out_data = static_cast<unsigned int>(out_data_sig.read());
			//cout << " dps de tr_out.out_data tr_in.in_valid: " << tr_in.in_valid << "\n";
//			if(tr_out.out_data != 0) cout << "tr_out.out_data: " << tr_out.out_data << "\n";
			//cout << " dps de if(tr_out.out_data) tr_in.in_valid: " << tr_in.in_valid << "\n";
			out->put(tr_out);
			//cout << " dps de put(tr_out) tr_in.in_valid: " << tr_in.in_valid << "\n";
    }
  }
};
