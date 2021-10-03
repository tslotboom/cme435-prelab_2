`ifndef _GENERATOR_
`define _GENERATOR_
`include "transaction.sv"
class generator;

    // event to indicate the end of transaction generation
    event ended;

    // mailbox for sending packets to the driver
    mailbox gen2driv;

    // mailbox for sending repeat count to the scoreboard
    mailbox gen2scb;

    // constructor
    function new(mailbox gen2driv, mailbox gen2scb);
        // get the mailbox handle from env
        this.gen2driv = gen2driv;
        this.gen2scb = gen2scb;
    endfunction

    // declare transaction class
    transaction trans;

    bit op_code;

    // repeat count, to specify number of items to generate
    int repeat_count;

    // number of transactions
    int num_transactions;

    // main task to generate (create and randomize) the repeat number of
    // transaction packets
    task main();
        repeat(repeat_count) begin
            trans = new();
            trans.op = 0 ? num_transactions < 5 : 1; // add or subtract half of the time
            trans.a = $random();
            trans.b = $random();
            trans.display("[Generator]");
            gen2driv.put(trans);
            gen2scb.put(repeat_count);
            num_transactions++;
        end


    -> ended; // trigger the end of generation
    endtask
endclass
`endif // _GENERATOR_
