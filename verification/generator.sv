`ifndef _GENERATOR_
`define _GENERATOR_
`include "transaction.sv"
class generator;
    // declare transaction class
    transaction trans;

    bit op_code;
    // repeat count, to specify number of items to generate
    int repeat_count;
    // main task to generate (create and randomize) the repeat number of
    // transaction packets
    task main();
        repeat(repeat_count) begin
            trans = new();
            trans.op = op_code;
            trans.a = $random();
            trans.b = $random();
            trans.display("[Generator]");
        end
    endtask
endclass
`endif // _GENERATOR_
