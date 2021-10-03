`ifndef _DRIVER_
`define _DRIVER_
class driver;
    // count the number of transactions
    int num_transactions;

    // create virtual interface handle
    virtual intf vif;

    // create mailbox handle
    mailbox gen2driv;

    // constuctor
    function new(virtual intf vif, mailbox gen2driv);
        // get the interface
        this.vif = vif;
        // get the mailbox handles from environment
        this.gen2driv = gen2driv;
    endfunction

    // drive the transaction items to interface signals
    task main;
        forever begin
            transaction trans;
            gen2driv.get(trans);
            @ (posedge vif.clk);
            vif.en  <= 1;
            vif.op  <= trans.op;
            vif.a   <= trans.a;
            vif.b   <= trans.b;
            @(posedge vif.clk);
            vif.en  <= 0;
            @(posedge vif.clk);
            trans.display("[Driver]");
            num_transactions++;
        end
    endtask
endclass
`endif // _DRIVER_
