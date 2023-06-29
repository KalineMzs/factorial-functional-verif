class factorial_scoreboard extends uvm_scoreboard;
    `uvm_component_utils (factorial_scoreboard)
    typedef factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) factorial_seq_item_param;

    parameter SHOW_MAX = 1000;
    uvm_tlm_fifo #(factorial_seq_item_param) refmod_port;
    uvm_tlm_analysis_fifo #(factorial_seq_item_param) dut_port, refmod_sv_port;
    factorial_seq_item_param dut_tr, refmod_tr, refmod_sv_in_tr, refmod_sv_out_tr;
    uvm_comparer comparer;

    factorial_refmod_sv refmod_sv;

    int n_match;
    bit match_result = 0;

    function new(string name = "factorial_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        dut_port = new("dut_port", this);
        refmod_sv_port = new("refmod_sv_port", this);
        refmod_port = new("refmod_port", this);
        comparer = new();
        n_match = 0;
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        comparer.verbosity = UVM_LOW;
        comparer.show_max = SHOW_MAX;
        refmod_sv = factorial_refmod_sv::type_id::create("refmod_sv", this);
        dut_tr = factorial_seq_item_param::type_id::create("dut_tr", this);
        refmod_tr = factorial_seq_item_param::type_id::create("refmod_tr", this);
        refmod_sv_in_tr = factorial_seq_item_param::type_id::create("refmod_sv_in_tr", this);
        refmod_sv_out_tr = factorial_seq_item_param::type_id::create("refmod_sv_out_tr", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    virtual task main_phase (uvm_phase phase);
        forever begin
            fork
                dut_port.get(dut_tr);
                refmod_port.get(refmod_tr);
                begin
                    refmod_sv_port.get(refmod_sv_in_tr);
                    refmod_sv_out_tr = refmod_sv.exec_factorial(refmod_sv_in_tr);
                end
            join
            match_result = my_comparer(dut_tr, refmod_sv_out_tr, "DUT_X_RFM");
            match_result &= my_comparer(refmod_tr, refmod_sv_out_tr, "SC_X_RFM");
            if (match_result) n_match++;
        end
    endtask

    function bit my_comparer(factorial_seq_item_param tr1, tr2, string pattern = "Signal");
        bit result;

        result = comparer.compare_field($sformatf("%s: out_data", pattern),
                                                   tr1.out_data, tr2.out_data, OUT_DATA_WD, UVM_DEC);
        result &= comparer.compare_field($sformatf("%s: out_valid", pattern), tr1.out_valid, tr2.out_valid, 1);
        result &= comparer.compare_field($sformatf(" %s: out_busy", pattern), tr1.out_busy, tr2.out_busy, 1);

        return result;
    endfunction
endclass
