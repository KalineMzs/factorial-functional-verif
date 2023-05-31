class factorial_in_monitor extends uvm_monitor;
    `uvm_component_utils(factorial_in_monitor)

    factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) in_tr;
    factorial_vif vif;

    uvm_analysis_port #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) mon_in_port;

    function new(string name = "factorial_in_monitor", uvm_component parent = null);
        super.new(name, parent);
        mon_in_port = new ("mon_in_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        assert(uvm_config_db#(factorial_vif)::get(this, "", "vif", vif));
        in_tr = factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD)::type_id::create("in_tr", this);
    endfunction

    virtual task main_phase (uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            wait(vif.resetn === 1'b1);
			in_tr.in_data = {vif.in_data, vif.in_valid};
            in_tr.in_valid = vif.in_valid;
            mon_in_port.write(in_tr);
        end
    endtask
endclass
