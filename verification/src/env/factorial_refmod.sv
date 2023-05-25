class factorial_refmod extends uvm_component;
    `uvm_component_utils(factorial_refmod)
    
    factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) in_tr, out_tr;
    uvm_get_port #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) refmod_in_port;
    uvm_put_port #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD)) refmod_out_port;

    function new(string name = "factorial_refmod", uvm_comopnent parent);
        super.new(name, parent);
        refmod_in_port = new("refmod_in_port", this);
        refmod_out_port = new("refmod_out_port", this);
    endfunction

    virtual function build_phase (uvm_phase phase);
        super.build_phase(phase);
        out_tr = factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD)::type_id::create("out_tr", this);
    endfunction

    virtual task run_phase (uvm_phase phase);
        super.run_phase(phase);

        forever begin
            in.get(in_tr);
            out_tr.copy(in_tr);
            refmod_out_port.put(out_tr);
        end
    endtask
endclass