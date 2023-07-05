class factorial_env extends uvm_env;
    `uvm_component_utils (factorial_env)

    factorial_in_agent in_agt;
    factorial_out_agent out_agt;
    factorial_scoreboard scoreboard;
    factorial_coverage coverage;

    function new(string name = "factorial_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        in_agt = factorial_in_agent::type_id::create("in_agt", this);
        out_agt = factorial_out_agent::type_id::create("out_agt", this);
        scoreboard = factorial_scoreboard::type_id::create("scoreboard", this);
        coverage = factorial_coverage::type_id::create("coverage", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
		uvmc_tlm1 #(factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD))::connect(in_agt.sc_fifo.get_export, "sc_in");
		uvmc_tlm1 #(factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD))::connect(scoreboard.sc_fifo.put_export, "sc_out");
        out_agt.out_port.connect(scoreboard.dut_fifo.analysis_export);
        in_agt.in_port.connect(coverage.cov_imp);
        in_agt.in_port.connect(scoreboard.rfm_fifo.analysis_export);
    endfunction
endclass
