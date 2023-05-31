typedef virtual factorial_interface #(IN_DATA_WD, OUT_DATA_WD) factorial_vif;

class factorial_driver extends uvm_driver #(factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD));
    `uvm_component_utils(factorial_driver)

    factorial_seq_item #(IN_DATA_WD, OUT_DATA_WD) in_tr;
    factorial_vif vif;

    function new(string name = "factorial_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        assert(uvm_config_db#(factorial_vif)::get(this, "", "vif", vif));
    endfunction

    virtual task main_phase (uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(in_tr);
            @(posedge vif.clk);
            if (vif.resetn === 1'b1) begin
				vif.in_valid = 'b1;
		        vif.in_data = 'b111;
//		        vif.in_valid = vif.in_data[0];
//		        vif.in_data = vif.in_data[2:1];
			end
			else begin
				vif.in_valid = 'd1;
		        vif.in_data = 'b0110; //6
			end
            seq_item_port.item_done();
        end
    endtask
endclass
