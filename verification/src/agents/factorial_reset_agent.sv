class factorial_reset_agent extends uvm_agent;
    `uvm_component_utils(factorial_reset_agent)
    
    factorial_reset_driver rst_drv;
    
    function new(string name = "factorial_reset_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        rst_drv = factorial_reset_driver::type_id::create("rst_drv", this);
    endfunction
endclass
