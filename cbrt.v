
module cubic_root (
    input clk,
    input rst,
    input start,
    input [15:0] x_bi,
    output wire [1:0] busy,
    output wire [7:0] m_temp,
    output reg [7:0] i,
    output reg [15:0] out,
    output reg [15:0] res
);

localparam IDLE = 2'h0;
localparam WORK = 2'h1;
localparam WORK_IN_WORK = 2'h2;
localparam WAIT_MULT = 2'h3;
 
reg [1:0]   state;
reg [7:0]   m;
reg [15:0]  x_b;
reg [15:0]  a;
reg [15:0]  b;

 
wire [1:0] multi_busy;
wire [15:0] mult_out_res;
reg start_mult;
 
 
assign busy = state;
assign m_temp = m;


mult b_square_calc( 
    .clk(clk), 
    .reset(rst), 
    .start(start_mult), 
    .a_bi(a), 
    .b_bi(b), 
    .busy_o(multi_busy), 
    .y_bo(mult_out_res)
);


always @(posedge clk)
    if (rst) begin
        m <= 1;
        res <= 1;
        state <= IDLE;
        out <= 0;
        start_mult <= 1'b0;
    end else begin
        case (state)
            IDLE:
                begin
                start_mult <= 1'b0;
                if (start) begin
                    state <= WORK;
                    x_b <= x_bi;
                    m <= 1;
                    res <= 1;
                end
                end
            WORK:
                if (res > x_b) 
                begin
                    state <= IDLE;
                    out <= m - 2;
                end 
                else if (res == x_b)
                begin
                    state <= IDLE;
                    out <= m - 1;
                end
                else begin
                    state <= WORK_IN_WORK;
                    res <= m;
                    i <= 1;
                end
            WORK_IN_WORK:
                begin
                    if (i == 3) begin
                        m <= m + 1;
                        state <= WORK; 
                    end else begin
                        state <= WAIT_MULT;
                        start_mult <= 1'b1;
                        a <= m;
                        b <= res;
                        i <= i + 1;
                    end 
                end
            WAIT_MULT:
            begin
                start_mult <= 1'b0;
               if (!multi_busy) begin
                    state <= WORK_IN_WORK;               
                    res <= mult_out_res;
                end
            end
        endcase
    end
endmodule