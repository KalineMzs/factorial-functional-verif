class random_test extends uvm_test;
	`uvm_component_utils(random_test)

	factorial_env env;
	factorial_random_sequence seq;
	factorial_vif vif;

	int clk_counter, MAX_COUNTER;

	function new(string name, uvm_component parent = null);
		super.new(name, parent);
		clk_counter = 0;

		if (!$value$plusargs("c=%0d", MAX_COUNTER)) begin
		MAX_COUNTER = 2000;
		`uvm_info("CLOCK", $sformatf("Clock configured: %0d clocks", MAX_COUNTER), UVM_LOW)
		end
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		assert(uvm_config_db#(factorial_vif)::get(this, "", "vif", vif));
		env = factorial_env::type_id::create("env", this);
		seq = factorial_random_sequence::type_id::create("seq", this);
	endfunction

	virtual task main_phase(uvm_phase phase);
		phase.raise_objection(this);
		while (clk_counter != MAX_COUNTER) begin
			@(posedge vif.clk);
			seq.start(env.in_agt.sqr);
			clk_counter++;
		end
		phase.drop_objection(this);
	endtask

	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("MATCH", $sformatf("Data match: %0d", env.scoreboard.n_match), UVM_LOW)
	endfunction
endclass