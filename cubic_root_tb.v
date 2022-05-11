// TestBench for cubic_root.v
`timescale 1ns/1ps

module cubic_test();
    reg clk;
    reg reset;
    reg start;
    reg [7:0] a;

    wire busy;
    wire [7:0] out;

    cubic_root uut(
        .clk(clk),
        .reset(reset),
        .x_b(a),
        .start(start),
        .busy(busy),
        .y_b(out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cubic_root_tb.vcd");
        $dumpvars(0, cubic_test);

        clk = 1'b0;
        reset = 1;
        start = 1;
        $display("input = %d; output = %d", a, out);

        #10;
        reset = 0;
        start = 1;
        a = 8'd10;
        $display("input = %d; output = %d", a, out);

        #10;
        start = 0;
        
        #100;

        $display("input = %d; output = %d", a, out);

        #20;
        $finish;
    end

endmodule
