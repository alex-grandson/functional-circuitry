// Testbench for mult.v
`timescale 1ns/1ps

module test (
);
    reg [7:0] a_bi;
    // reg [7:0] b_bi = 8'b00001000;

    reg clk_i;
    reg rst_i;
    reg start_i;

    reg [7:0] a;
    reg [7:0] b;

    wire busy;
    wire [15:0] out;
    
    mult uut(
        .clk(clk_i), 
        .reset(rst_i), 
        .a_bi(a_bi), 
        .b_bi(a_bi), 
        .start(start_i), 
        .busy_o(busy), 
        .y_bo(out)
    );

    always #5 clk_i = ~clk_i;

    initial begin
        $dumpfile("mult_tb.vcd");
        $dumpvars(0, test);

        clk_i = 1'b0; rst_i = 1; start_i = 0;
        $display("       A                     OUT");
        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);
        
        #10 rst_i = 0; start_i = 1; a_bi = 8'b00001000;
        $display("       A                     OUT");
        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);
        
        #10 start_i = 0; a_bi = 0;
        
        #10 rst_i = 0;
        
        #80 

        $display("       A                     OUT");
        $display("%b (%d)  %b (%d)", a_bi, a_bi, out, out);

        $finish;

    end

endmodule