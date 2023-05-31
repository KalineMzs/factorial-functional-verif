interface factorial_interface
#( parameter IN_DATA_WD = 3,
             OUT_DATA_WD = 16
)(input clk, resetn);
    logic [IN_DATA_WD-1:0] in_data;
    logic in_valid;
    logic [OUT_DATA_WD-1:0] out_data;
    logic out_valid;
    logic out_busy;

  modport dut (
    input clk,
    input resetn,
    input in_data,
    input in_valid,
    output out_data,
    output out_valid,
    output out_busy
  );
endinterface
