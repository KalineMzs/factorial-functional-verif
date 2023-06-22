class factorial_random_sequence extends uvm_sequence #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD));
    `uvm_object_utils(factorial_random_sequence)
    
    function new (string name = "factorial_random_sequence");
        super.new(name);
    endfunction

    task body();
        factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) in_tr;
        in_tr = factorial_seq_item#(IN_DATA_WD, OUT_DATA_WD)::type_id::create("in_tr");
        start_item(in_tr);
        assert(in_tr.randomize());
        finish_item(in_tr);
    endtask
endclass