class factorial_seq_item #(int IN_DATA_WD = 3, OUT_DATA_WD = 16) extends uvm_sequence_item;
    `uvm_object_param_utils(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD))

    rand bit in_valid;
    rand bit [IN_DATA_WD-1:0] in_data;
    rand bit out_valid;
    rand bit [OUT_DATA_WD-1:0] out_data;
    rand bit out_busy;

    constraint in_valid_generation {in_valid dist {1:=80, 0:=20}; }
    constraint in_data_generation {in_data != 0; } // Added to avoid 0 factorial bug

    virtual function void do_pack(uvm_packer packer);
        `uvm_pack_int(in_valid)
        `uvm_pack_int(in_data)
        `uvm_pack_int(out_valid)
        `uvm_pack_int(out_busy)
        `uvm_pack_int(out_data)
    endfunction

    virtual function void do_unpack(uvm_packer packer);
        `uvm_unpack_int(in_valid)
        `uvm_unpack_int(in_data)
        `uvm_unpack_int(out_valid)
        `uvm_unpack_int(out_busy)
        `uvm_unpack_int(out_data)
    endfunction

    function new (string name="factorial_in_seq_item");
        super.new (name);
    endfunction
endclass
