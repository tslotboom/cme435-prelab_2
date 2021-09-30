`ifndef _ENVIRONMENT_
`define _ENVIRONMENT_
`include "generator.sv"
class environment;

  // generator instance
  generator gen;

  // virtual interface
  virtual intf vif;

  // constructor
  function new(virtual intf vif);
    // get the interface from test
    this.vif = vif;
    // create generator
    gen = new();

  endfunction

  task pre_test();
    $display("[Environment]: Start of pre_test() at %0d", $time);
    reset();
    $display("[Environment]: End of pre_test() at %0d", $time);
  endtask

  task test();
    $display("[Environment]: Start of test() at %0d", $time);
    gen.main();
    $display("[Environment]: End of test() at %0d", $time);
  endtask

  task post_test();
    $display("[Environment:] Start of post_test() at %0d", $time);
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
