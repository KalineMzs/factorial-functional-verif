`include "uvm_macros.svh"

`include "factorial_tb_cfg_pkg.sv"
`include "agents/factorial_interface.sv"
`include "factorial_top_pkg.sv"

`timescale 1ps/1ps
module factorial_top;
    import uvm_pkg::*;
	import uvmc_pkg::*;
    import factorial_tb_cfg_pkg::*;
    import factorial_top_pkg::*;

    logic clk, resetn;

	initial uvmc_init();

    initial begin
        clk = 'b0;
        resetn = 'b0;
        #10 resetn = 'b1;
    end

    always #5 clk = !clk;

    factorial_interface #(IN_DATA_WD, OUT_DATA_WD) factorial_if (
        .clk(clk),
        .resetn(resetn)
    );

    FactorialBlk #(IN_DATA_WD, OUT_DATA_WD) dut (
        .clk(clk),
        .resetn(resetn),
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
