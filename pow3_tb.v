`timescale 1ns / 1ps

module pow3_test();

    reg [7:0] a_bi;
    reg start_i;
    reg clk_i;
    reg rst_i;

    wire busy;
    wire [23:0] out;

    pow3 uut(
        .clk_i(clk_i), 
        .rst_i(rst_i), 
        .a_bi(a_bi), 
        .start_i(start_i), 
        .busy_o(busy), 
        .y_bo(out)
    );
    always #5 clk_i = ~clk_i;

    initial begin
        $dumpfile("pow3.vcd");
        $dumpvars(0, pow3_test);

        clk_i = 1'b0; rst_i = 1; start_i = 0;


        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);

        #10 rst_i = 0; start_i = 1; a_bi = 8'b00001000;
        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);


        #10 start_i = 0;
        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);


        #10 rst_i = 0;
        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);


        #160

        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);
        
        $finish;
    end
endmodule