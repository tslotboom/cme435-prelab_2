`ifndef _TEST_TRANSACTION_
`define _TEST_TRANSACTION_
`include "transaction.sv"
program test_transaction_class
    transaction trans;

    initial begin
        trans = new();
        repeat(10) begin
            // trans.op = $random();
            trans.a = $random();
            trans.b = $random();
            trans.display("[test_transaction_class]");
        end
    end
endprogram : test_transaction_class
`ENDIF //_TEST_TRANSACTION_
