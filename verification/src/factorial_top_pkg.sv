package factorial_top_pkg;
    import uvm_pkg::*;

    import factorial_tb_cfg_pkg::*;
    `include "agents/factorial_seq_item.sv"
    `include "sequences/factorial_random_sequence.sv"
    `include "agents/factorial_sequencer.sv"
    `include "agents/factorial_driver.sv"
    `include "agents/factorial_in_monitor.sv"
    `include "agents/factorial_in_agent.sv"
    `include "agents/factorial_out_monitor.sv"
    `include "agents/factorial_out_agent.sv"

    `include "env/factorial_refmod.sv"
    `include "env/factorial_scoreboard.sv"
    `include "env/factorial_env.sv"

    `include "tests/random_test.sv"
endpackage
