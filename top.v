module top (
    input        clk, 
    input        rst, 
    input        start, 
    input [15:0] a; 
    input [15:0] b; 
    output wire [1:0]   busy, 
    output reg [15:0]   out,
);
    localparam IDLE = 2'h0; 
    localparam WORK = 2'h1; 
    localparam WORK_IN_WORK = 2'h2; 
    localparam WAIT_MULT = 2'h3;

    wire        multi_busy; 
    wire [15:0] mult_out_res; 
    reg         start_mult; 

    assign busy = state; 
    

endmodule

