`timescale 1ns / 1ns
`include "uvm_macros.svh"

`include "factorial_tb_cfg_pkg.sv"
`include "agents/factorial_interface.sv"
`include "factorial_top_pkg.sv"

module factorial_top;
    import uvm_pkg::*;
	import uvmc_pkg::*;
    import factorial_tb_cfg_pkg::*;
    import factorial_top_pkg::*;

    logic clk, resetn;

	initial uvmc_init();

    initial clk = 'b0;

    always #5 clk = !clk;

    factorial_interface #(IN_DATA_WD, OUT_DATA_WD) factorial_if (
        .clk(clk)
    );

    FactorialBlk #(IN_DATA_WD, OUT_DATA_WD) dut (
        .clk(clk),
        .resetn(factorial_if.dut.resetn),
        .in_data(factorial_if.dut.in_data),
        .in_valid(factorial_if.dut.in_valid),
        .out_data(factorial_if.dut.out_data),
        .out_valid(factorial_if.dut.out_valid),
        .out_busy(factorial_if.dut.out_busy)
    );
    initial begin
        uvm_config_db#(virtual factorial_interface#(IN_DATA_WD, OUT_DATA_WD))::set(uvm_root::get(), "*", "vif", factorial_if);
    end

	initial run_test();
endmodule
