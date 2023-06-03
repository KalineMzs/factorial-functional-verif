class factorial_coverage extends uvm_component;
    `uvm_component_utils (factorial_coverage)
	typedef factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) factorial_seq_item_param;

    uvm_analysis_imp #(factorial_seq_item_param, factorial_coverage) cov_port;

    factorial_seq_item_param in_tr;

    covergroup cg;
        option.per_instance = 1;

        valid: coverpoint in_tr.in_valid {
            option.at_least = 100;

            bins transition[] = (0,1 => 0,1);
        }

        data: coverpoint in_tr.in_data {
            option.at_least = 10;

            bins min = {0};
            bins max = { {IN_DATA_WD{1'b1}} };
            bins values [3] = {[0:$]};
        }
    endgroup

    function new(string name = "factorial_coverage", uvm_component parent = null);
        super.new(name, parent);
        cov_port = new("cov_port", this);
        cg = new();
    endfunction

    virtual function void write (factorial_seq_item_param tr);
        in_tr = tr;
        cg.sample();
    endfunction
endclass
