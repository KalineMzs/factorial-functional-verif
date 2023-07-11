class factorial_in_agent extends uvm_agent;
    `uvm_component_utils(factorial_in_agent)

    factorial_sequencer sqr;
    factorial_driver drv;
    factorial_in_monitor in_mon;

    uvm_tlm_analysis_fifo #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) sc_fifo;
    uvm_analysis_port #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) in_port;

    function new(string name = "factorial_in_agent", uvm_component parent = null);
        super.new(name, parent);
        sc_fifo = new ("sc_fifo", this);
        in_port = new ("in_port", this);
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
        in_mon.in_port.connect(sc_fifo.analysis_export);
        in_mon.in_port.connect(in_port);
    endfunction
endclass
