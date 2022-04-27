// Testbench for adder.v

`timescale 1ns / 1ps

module adder_test();

    // reg clk_i;
    // reg rst_i;
    // reg start_i;

    reg  [7:0]  a;
    reg  [7:0]  b;
    wire [15:0] out;

    adder uut(.a(a), .b(b), .out(out));

    initial begin
        $dumpfile("adder_tb.vcd");
        $dumpvars(0, adder_test);

        a = 10;
        b = 10;

        $display("a = %d (%d)", a, a);
        $display("b = %d (%d)", b, b);
        $display("r = %d (%d)", out, out);

        #10

        $finish;
    end

endmodule