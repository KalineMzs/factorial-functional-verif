class factorial_scoreboard extends uvm_scoreboard;
    `uvm_component_utils (factorial_scoreboard)
    typedef factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) factorial_seq_item_param;

    parameter SHOW_MAX = 1000;

    uvm_tlm_fifo #(factorial_seq_item_param) sc_port;
    uvm_tlm_analysis_fifo #(factorial_seq_item_param) dut_port, rfm_port;

    factorial_seq_item_param dut_tr, sc_tr, rfm_in_tr, rfm_out_tr;

    factorial_refmod rfm;
    uvm_comparer comparer;

    int n_match;
    bit match_result = 0;

    function new(string name = "factorial_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        dut_port = new("dut_port", this);
        rfm_port = new("rfm_port", this);
        sc_port = new("sc_port", this);
        comparer = new();
        n_match = 0;
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        comparer.verbosity = UVM_LOW;
        comparer.show_max = SHOW_MAX;
        dut_tr = factorial_seq_item_param::type_id::create("dut_tr", this);
        sc_tr = factorial_seq_item_param::type_id::create("sc_tr", this);
        rfm = factorial_refmod::type_id::create("rfm", this);
        rfm_in_tr = factorial_seq_item_param::type_id::create("rfm_in_tr", this);
        rfm_out_tr = factorial_seq_item_param::type_id::create("rfm_out_tr", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    virtual task main_phase (uvm_phase phase);
        forever begin
            fork
                dut_port.get(dut_tr);
                sc_port.get(sc_tr);
                begin
                    rfm_port.get(rfm_in_tr);
                    rfm_out_tr = rfm.exec_factorial(rfm_in_tr);
                end
            join
            match_result = my_comparer(dut_tr, rfm_out_tr, "DUT_X_RFM");
            match_result &= my_comparer(sc_tr, rfm_out_tr, "SC_X_RFM");
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
