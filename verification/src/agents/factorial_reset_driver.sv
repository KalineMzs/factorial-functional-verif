class factorial_reset_driver extends uvm_driver #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD));
    `uvm_component_utils(factorial_reset_driver)
    
    factorial_vif vif;
    
    int RST_INTERVAL = 1000, RST_DURATION = 3;

    function new(string name = "factorial_reset_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        assert(uvm_config_db#(factorial_vif)::get(this, "", "vif", vif));
		assert(uvm_config_db#(int)::get(this, "", "RST_INTERVAL", RST_INTERVAL));
		assert(uvm_config_db#(int)::get(this, "", "RST_DURATION", RST_DURATION));
    endfunction
    
    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        repeat (RST_DURATION) begin
            vif.resetn = 0;        
            @(posedge vif.clk);
        end
        phase.drop_objection(this);
    endtask

    virtual task main_phase (uvm_phase phase);
        repeat (RST_INTERVAL) begin
            vif.resetn = 1;
            @(posedge vif.clk);
        end
        phase.jump(uvm_reset_phase::get());
    endtask
endclass
