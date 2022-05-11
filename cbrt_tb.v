`timescale 1ns / 1ps

module cbrt_test;
    
    reg clk;
    reg rst;
    reg start;
    reg [15:0]  x_bi;
    wire [1:0]  busy;
    wire [7:0]  mmm;
    wire [15:0]  out;
    wire [15:0] res;
    wire [7:0]  i;
    
    always #1 clk = ~clk;
    
    cbrt cbrt_t(
        .clk(clk),
        .rst(rst),
        .start(start),
        .x_bi(x_bi),
        .busy(busy),
        .mmm(mmm),
        .out(out),
        .res(res),
        .i(i)
    );
    
    initial begin
      $dumpfile("out.vcd");
      $dumpvars(0,cbrt_test);
      
      clk = 1;
      start = 1;
      rst = 1; 
      x_bi = 8'h1B;
      #5
      rst = 0;
      #100
      $finish;
    end
endmodule