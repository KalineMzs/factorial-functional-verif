#include <systemc.h>
#include "tlm.h"
#include "factorial_cpp.hpp"
#include "uvmc.h"

using namespace uvmc;
using namespace std;
using namespace tlm;

class tr {
	public:
		bool in_valid;
		sc_uint<3> in_data;
		bool out_valid;
		bool out_busy;
		sc_uint<16> out_data;
};


template <>
struct uvmc_converter<tr> {
    static void do_pack (const tr &t, uvmc_packer &packer) {
        packer << t.in_valid << t.in_data << t.out_valid << t.out_busy << t.out_data;
    }

    static void do_unpack (tr &t, uvmc_packer &packer) {
        packer >> t.in_valid >> t.in_data >> t.out_valid >> t.out_busy >> t.out_data;
    }
};
// UVMC_UTILS_5(tr, in_valid, in_data, out_valid, out_busy, out_data)

SC_MODULE(factorial_sc) {
    sc_port<tlm_get_peek_if<tr> > in;
    sc_port<tlm_put_if<tr> > out;

	sc_signal<bool> clk_sig;
	sc_signal<bool> resetn_sig;
	sc_signal<bool> in_valid_sig;
	sc_signal<int> in_data_sig;

	sc_signal<bool> out_valid_sig;
	sc_signal<bool> out_busy_sig;
	sc_signal<int> out_data_sig;

	factorial_cpp factorial;

    SC_CTOR(factorial_sc): in("in"), out("out"), factorial("factorial") {
        factorial.clk(clk_sig);
        factorial.resetn(resetn_sig);
        factorial.in_valid(in_valid_sig);
        factorial.in_data(in_data_sig);

        factorial.out_valid(out_valid_sig);
        factorial.out_busy(out_busy_sig);
        factorial.out_data(out_data_sig);

        SC_THREAD(run);
    }

    void run() {
        tr tr_in, tr_out;

        clk_sig = 0;
        while(1){
            in->get(tr_in);

            resetn_sig = 1;
            in_data_sig = tr_in.in_data;
            in_valid_sig = tr_in.in_valid;

            clk_sig = 1;

            tr_out.out_valid = out_valid_sig.read();
            tr_out.out_busy = out_busy_sig.read();
            tr_out.out_data = out_data_sig.read();

            out->put(tr_out);
            clk_sig = 0;
        }
    }
};
