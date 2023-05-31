class factorial_scoreboard extends uvm_scoreboard;
    `uvm_component_utils (factorial_scoreboard)

    parameter SHOW_MAX = 1000;
    uvm_tlm_fifo #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) refmod_port;
    uvm_tlm_analysis_fifo #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) dut_port;

    factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) dut_tr, refmod_tr;

    uvm_comparer comparer;

    int n_match;
    bit match_result = 0;

    function new(string name = "factorial_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        dut_port = new("dut_port", this);
        refmod_port = new("refmod_port", this);
        comparer = new();
        n_match = 0;
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        comparer.verbosity = UVM_LOW;
        comparer.sev = UVM_ERROR;
        comparer.show_max = SHOW_MAX;
		dut_tr = factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD)::type_id::create("dut_tr", this);
		refmod_tr = factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD)::type_id::create("refmod_tr", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    virtual task main_phase (uvm_phase phase);
        forever begin
            fork
                dut_port.get(dut_tr);
                refmod_port.get(refmod_tr);
            join

//            match_result = comparer.compare_field("Signal: out_data", dut_tr.out_data, refmod_tr.out_data, OUT_DATA_WD);
//                           & comparer.compare_field("Signal: out_valid", dut_tr.out_valid, refmod_tr.out_valid, 1)
//                           & comparer.compare_field("Signal: out_busy", dut_tr.out_busy, refmod_tr.out_busy, 1);
            if (match_result) n_match++;
        end
    endtask
endclass

