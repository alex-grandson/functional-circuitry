`timescale 1ns / 1ps

module cubic_test;
    
    reg clk;
    reg rst;
    reg start;
    reg [15:0]  x_bi;
    wire [1:0]  busy;
    wire [7:0]  m_temp;
    wire [15:0] out;
    wire [15:0] res;
    wire [7:0]  i;
    
    always #5 clk = ~clk;
    
    cubic_root cbrt_t(
        .clk(clk),
        .rst(rst),
        .start(start),
        .x_bi(x_bi),
        .busy(busy),
        .m_temp(m_temp),
        .out(out),
        .res(res),
        .i(i)
    );
    
    initial begin
      $dumpfile("cubic_test.vcd");
      $dumpvars(0, cubic_test);
      
      clk = 0;
      start = 0;
      rst = 1;
      x_bi = 0;

      #10
      
      rst = 0;
      start = 1;
      x_bi = 8'h1B;

      #10
      start = 0;
      x_bi = 0;


      
      #1000
      $display("input = %d; output = %d", x_bi, out);


      $finish;
    end
endmodule