class factorial_in_agent extends uvm_agent;
    `uvm_component_utils(factorial_in_agent)

    factorial_sequencer sqr;
    factorial_driver drv;
    factorial_in_monitor in_mon;

    uvm_tlm_analysis_fifo #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) agt_in_port;
    uvm_analysis_port #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) agt_in_to_cov_port;

    function new(string name = "factorial_in_agent", uvm_component parent = null);
        super.new(name, parent);
        agt_in_port = new ("agt_in_port", this);
        agt_in_to_cov_port = new ("agt_in_to_cov_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        sqr = factorial_sequencer::type_id::create("sqr", this);
        drv = factorial_driver::type_id::create("drv", this);
        in_mon = factorial_in_monitor::type_id::create("in_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        in_mon.mon_in_port.connect(agt_in_port.analysis_export);
        in_mon.mon_in_port.connect(agt_in_to_cov_port);
    endfunction
endclass