mult: clean
	iverilog -o mult.out mult.v mult_tb.v
	vvp mult.out
	gtkwave mult.vcd

pow: clean
	iverilog -o pow3.out pow3.v pow3_tb.v
	vvp pow3.out
	gtkwave pow3.vcd

func: clean
	iverilog -o func.out pow3.v mult.v adder.v func.v func_tb.v
	vvp func.out
	gtkwave func.vcd

clean:
	rm -rf *.out *.vcd