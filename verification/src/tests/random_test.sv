class random_test extends uvm_test;
  factorial_env env;
  factorial_random_sequence seq;

  `uvm_component_utils(random_test)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = factorial_env::type_id::create("env", this);
    seq = factorial_random_sequence::type_id::create("seq", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    seq.start(env.in_agt.sqr);
  endtask: run_phase

endclass
