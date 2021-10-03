`ifndef _ENVIRONMENT_
`define _ENVIRONMENT_
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;

  // generator, driver, monitor and scoreboard instances
  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;

  // mailbox handles
  mailbox gen2driv;
  mailbox mon2scb;
  mailbox gen2scb;

  // virtual interface
  virtual intf vif;

  // error count
  int signed error_count;

  // constructor
  function new(virtual intf vif);
    // get the interface from test
    this.vif = vif;
    // create mailbox(es) for data exchange
    gen2driv = new();
    mon2scb = new();
    gen2scb = new();

    // create generator, driver and monitor
    gen = new(gen2driv, gen2scb);
    driv = new(vif, gen2driv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb, gen2scb);

  endfunction

  task pre_test();
    $display("[Environment]: Start of pre_test() at %0d", $time);
    reset();
    $display("[Environment]: End of pre_test() at %0d", $time);
  endtask


  task test();
    $display("[Environment]: Start of test() at %0d", $time);
    fork
        gen.main();
        driv.main();
        mon.main();
        scb.main();
    join_any
    wait(gen.ended.triggered);
    wait(gen.repeat_count == driv.num_transactions);
    wait(gen.repeat_count == scb.num_transactions);
    error_count = scb.error_count;

    $display("[Environment]: End of test() at %0d", $time);
  endtask

  task post_test();
    $display("[Environment:] Start of post_test() at %0d", $time);
    $display("[Environment:] There were %0d errors.", error_count);
    $display("[Environment:] End of post_test at %0d", $time);
  endtask

  task run;
    $display("[Environment]: Start of run at %0d", $time);
    pre_test();
    test();
    post_test();
    $display("[Environment]: End of run() at %0d", $time);
    $finish;
  endtask

  task reset();
      wait(vif.reset);

      $display("[Environment]: Reset started at %0d", $time);
  endtask

endclass
`endif //_ENVIRONMENT_
