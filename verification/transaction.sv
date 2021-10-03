`ifndef _TRANSACTION_
`define _TRANSACTION_
class transaction;
    bit         op;
    bit [3:0]   a;
    bit [3:0]   b;
    bit [7:0]   y;
    function void display(string name);
        $display("----------");
        $display("%s: a = %0d, b = %0d", name, a, b);
        $display("%s: op = %0d: y = %0d", name, op, y);
    endfunction
endclass
`endif //_TRANSACTION_
