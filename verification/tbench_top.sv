`ifndef _TBENCH_TOP_
`define _TBENCH_TOP_
module tbench_top;

  // clock and reset signal declaration
  bit clk;
  bit reset;

  // clock generation
  always #5 clk = ~clk;

  // reset generation
  initial begin
    reset = 1;
    #6 reset = 0;
  end

  // create interface instance to connect DUT and testcase
  intf i_intf(clk, reset);
  // create testcase instance where interface handle is passed to test as an argument
  testbench test(i_intf);
  // create DUT instance where interface signals are connected to the DUT ports
  dut_top dut(i_intf);

  initial begin
    $dumpfile("dumpfile.vcd"); $dumpvars;
  end
endmodule
`endif // _TBENCH_TOP_
