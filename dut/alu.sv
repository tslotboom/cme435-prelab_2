module alu(
  input wire         clk,
  input wire         reset,
  input wire         en,
  input wire         op,  
  input wire   [3:0] a,
  input wire   [3:0] b,
  output logic [7:0] y); 
  
  reg [7:0] y_tmp;
  
  // reset 
  always @(posedge reset) 
    y_tmp <= 0;
   
  // addition/subtraction operations
  always @(posedge clk) 
    if (en) begin 
      if (op == 0) y_tmp <= a + b;
      if (op == 1) y_tmp <= a - b;
    end
  
  assign y = y_tmp;

endmodule