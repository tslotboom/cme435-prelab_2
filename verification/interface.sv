`ifndef _INTERFACE_
`define _INTERFACE_
interface intf(input logic clk, reset);
    logic en;
    logic op;
    logic [3:0] a;
    logic [3:0] b;
    logic [7:0] y;

endinterface
`endif
