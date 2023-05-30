class factorial_env extends uvm_env;
    `uvm_component_utils (factorial_env)

    factorial_in_agent in_agt;
    factorial_out_agent out_agt;
    factorial_scoreboard scoreboard;
    factorial_refmod refmod;

    function new(string name = "factorial_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        in_agt = factorial_in_agent::type_id::create("in_agt", this);
        out_agt = factorial_out_agent::type_id::create("out_agt", this);
        scoreboard = factorial_scoreboard::type_id::create("scoreboard", this);
        refmod = factorial_refmod::type_id::create("refmod", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
//        in_agt.agt_in_port.connect(refmod.refmod_in_port.analysis_export);
		uvmc_tlm1 #(factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD))::connect(in_agt.agt_in_port.get_export, "foo");
//        refmod.refmod_out_port.connect(scoreboard.refmod_port.analysis_export);
		uvmc_tlm1 #(factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD))::connect(scoreboard.refmod_port.put_export, "bar");
        out_agt.agt_out_port.connect(scoreboard.dut_port.analysis_export);
    endfunction
endclass
