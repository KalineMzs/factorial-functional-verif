class factorial_out_monitor extends uvm_monitor;
    `uvm_component_utils(factorial_out_monitor)

    factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) out_tr;
    factorial_vif vif;

    uvm_analysis_port #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) mon_out_port;

    function new(string name = "factorial_out_monitor", uvm_component parent = null);
        super.new(name, parent);
        mon_out_port = new ("mon_out_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        assert(uvm_config_db#(factorial_vif)::get(this, "", "vif", vif));
        out_tr = factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD)::type_ide::create("out_tr", this);
    endfunction

    virtual task main_phase (uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            wait(vif.resetn === 1'b1);
            out_tr.out_data = vif.out_data;
            out_tr.out_valid = vif.out_valid;
            out_tr.out_busy = vif.out_busy;
            mon_out_port.write(out_tr);
        end
    endtask
endclass
