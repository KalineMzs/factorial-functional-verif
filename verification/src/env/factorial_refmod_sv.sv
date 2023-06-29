class factorial_refmod_sv extends uvm_component;
    `uvm_component_utils(factorial_refmod_sv)
    typedef factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) factorial_seq_item_param;

    factorial_seq_item_param in_tr, out_tr;

    function new(string name = "factorial_refmod_sv", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
		in_tr = factorial_seq_item_param::type_id::create("in_tr", this);
		out_tr = factorial_seq_item_param::type_id::create("out_tr", this);
    endfunction

    function factorial_seq_item_param exec_factorial(factorial_seq_item_param data_in);
        return data_in;
    endfunction
endclass
