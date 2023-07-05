class factorial_refmod extends uvm_component;
    `uvm_component_utils(factorial_refmod)
    typedef factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) factorial_seq_item_param;

    factorial_seq_item_param out_tr;

    enum {INIT, CALC, DONE} state;
    int counter, calc_buffer;

    function new(string name = "factorial_refmod", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
		out_tr = factorial_seq_item_param::type_id::create("out_tr", this);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        out_tr.out_valid = 0;
        out_tr.out_busy = 0;
        counter = 0;
        calc_buffer = 1;
        state = INIT;
    endtask

    function factorial_seq_item_param exec_factorial(factorial_seq_item_param data_in);
        case (state)
            INIT: begin
                out_tr.out_valid <= 0;
                out_tr.out_busy <= 0;

                if (data_in.in_valid) begin
                    out_tr.out_busy <= 1;
                    counter = data_in.in_data;
                    if (counter == 0) counter = 1;
                    state = CALC;
                end
            end

            CALC: begin
                calc_buffer *= counter;
                counter --;
                if (counter == 0) state = DONE;
            end

            DONE: begin
                out_tr.out_valid <= 1;
                out_tr.out_busy <= 0;
                out_tr.out_data <= calc_buffer;
                calc_buffer = 1;
                state = INIT;
            end
        endcase

        return out_tr;
    endfunction
endclass
