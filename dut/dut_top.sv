module dut_top(interface i_intf);

	alu alu_core (
		.clk(i_int.clk),
		.reset(i_int.clk),
		.en(i_int.en),
		.op(i_int.op),
		.a(i_intf.a),
		.b(i_int.b),
		.y(i_intf.c)
		);
endmodule