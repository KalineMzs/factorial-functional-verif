class factorial_sequencer extends uvm_sequencer #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD));
    `uvm_component_utils(factorial_sequencer)

    function new(string name = "factorial_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass