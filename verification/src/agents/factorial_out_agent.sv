class factorial_out_agent extends uvm_agent;
    `uvm_component_utils(factorial_out_agent)

    factorial_out_monitor out_mon;

    uvm_analysis_port #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) agt_out_port;

    function new(string name = "factorial_out_agent", uvm_component parent = null);
        super.new(name, parent);
        agt_out_port = new ("agt_out_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        out_mon = factorial_out_monitor::type_id::create("out_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        out_mon.mon_out_port.connect(agt_out_port);
    endfunction
endclass