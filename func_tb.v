module func_test;

reg [7:0] a, b;
reg clk_i;
reg in_ready;
wire [11:0] out;
wire out_ready;

func func_instance(
    .a(a),
    .b(b),
    .in_ready(in_ready),
    .clk_i(clk_i),
    .out(out),
    .out_ready(out_ready)
);

integer i;


always #5 clk_i = ~clk_i;


initial begin
    $dumpfile("func.vcd");
    $dumpvars(0, func_test);
    clk_i = 0;

    #20
    
    a = 5;
    b = 2;
    in_ready = 1;
    
    #20
    
    in_ready = 0;
    
    #1500
    
    $display("Input: a) 0x%h, b) 0x%h Output: 0x%h", a, b, out);

    // for (i = 0; i < 256; i = i + 25) begin
    //     #20
    
    //     a = i;
    //     b = i + 2;
    //     in_ready = 1;
        
    //     #20
        
    //     in_ready = 0;
        
    //     #580
        
    //     $display("Input: a) 0x%h, b) 0x%h Output: 0x%h", a, b, out);
    // end
    $finish;
end
endmodule