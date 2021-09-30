module dut_top(interface i_intf);

	alu alu_core (
		.clk(i_intf.clk),
		.reset(i_intf.clk),
		.en(i_intf.en),
		.op(i_intf.op),
		.a(i_intf.a),
		.b(i_intf.b),
		.y(i_intf.y)
		);
endmodule
