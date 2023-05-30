class factorial_seq_item #(int IN_DATA_WD = 4, OUT_DATA_WD = 46) extends uvm_sequence_item;
    
    rand bit [IN_DATA_WD-1:0] in_data;
    rand bit in_valid;
    rand bit [OUT_DATA_WD-1:0] out_data;
    rand bit out_valid;
    rand bit out_busy;

    constraint in_valid_generation {in_valid dist {1:=80, 0:=20}; }

    `uvm_object_param_utils_begin(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD))
        `uvm_field_int(in_data, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(out_data, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(in_valid, UVM_ALL_ON|UVM_BIN)
        `uvm_field_int(out_valid, UVM_ALL_ON|UVM_BIN)
        `uvm_field_int(out_busy, UVM_ALL_ON|UVM_BIN)
    `uvm_object_utils_end
    
    function new (string name="factorial_in_seq_item");
        super.new (name);
    endfunction
endclass
