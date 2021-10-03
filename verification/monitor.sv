`ifndef _MONITOR_
`define _MONITOR_
class monitor;
    // create virtual interface handle
    virtual intf vif;

    // create mailbox handle
    mailbox mon2scb;

    // constructor
    function new (virtual intf vif, mailbox mon2scb);
        // get the interface
        this.vif = vif;
        // get the mailbox handles from enviroment
        this.mon2scb = mon2scb;
    endfunction

    task main;
        forever begin
            transaction trans;
            trans = new();
            @(posedge vif.clk);
            wait(vif.en);
            trans.op    =   vif.op;
            trans.a     =   vif.a;
            trans.b     =   vif.b;
            @(posedge vif.clk);
            trans.y     =   vif.y;
            @(posedge vif.clk);
            mon2scb.put(trans);
            trans.display("[Monitor]");
        end
    endtask

endclass
`endif // _MONITOR_
