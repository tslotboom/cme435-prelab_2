`ifndef _TESTBENCH_
`define _TESTBENCH_
`include "environment.sv"
program testbench(intf i_intf);

    // call the run task in env, which in turn calls other test tasks
    environment env;
    initial begin
        env = new(i_intf);

        // set the repeat count of generator such as 5, means to generate 5
        // packets
        env.gen.repeat_count = 5;
        $display("[Testbench]: Start of testcase(s) at %0d", $time);
        // call the run task in env, which in turn calls other test tasks
        env.run();
    end

    final
        $display("[Testbench]: End of testcase(s) at %0d", $time);

endprogram
`endif // _TESTBENCH_
