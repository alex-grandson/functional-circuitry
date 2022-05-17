mult:
	iverilog mult.v mult_tb.v
	vvp *.out
	gtkwave *.vcd

cb: 
	iverilog cbrt.v cbrt_tb.v mult.v
	vvp *.out
	gtkwave *.vcd


clean:
	rm -rf a.out *.vcd