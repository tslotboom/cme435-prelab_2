`ifndef _SCOREBOARD_
`define _SCOREBOARD_
class scoreboard;
    // create the mailbox handle
    mailbox mon2scb;

    // create mailbox from env to scoreboard
    mailbox gen2scb;

    // count the number of transactions
    int num_transactions = 0;

    // error count
    int error_count = 0;

    int signed expected_result;

    // constructor
    function new (mailbox mon2scb, mailbox gen2scb);
        // get the mailbox handle from environment
        this.mon2scb = mon2scb;
        this.gen2scb = gen2scb;
    endfunction

    // compare the actual result with the expected result
    task main;
        transaction trans;
        int repeat_count;
        forever begin
            mon2scb.get(trans);
            gen2scb.get(repeat_count);
            trans.display("[Scoreboard]");
            $display("[Scoreboard]: transaction %0d/%0d", num_transactions,
            repeat_count);
            if (trans.op == 0)
                 expected_result = trans.a + trans.b;
            else
                expected_result = trans.a - trans.b;
            if(expected_result == trans.y)
                $display("[Scoreboard]: Pass");
            else begin
                $error("[Scoreboard] Error: \n\tExpected result: %0d Received: %0d", expected_result, trans.y);
                error_count++;
            end
            num_transactions++;
        end
    endtask
endclass
`endif // _SCOREBOARD_
