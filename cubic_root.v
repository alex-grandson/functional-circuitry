`include "mult.v"

module cubic_root (
    input clk,
    input reset,
    input [7:0] x_b,
    input start,

    output busy,
    output reg [7:0] y_b
);
    localparam IDLE = 2'b0;     
    localparam WORK = 2'b1; 
    
    reg state;
    reg [7:0] b, x, s, y, b1, b2, b3;
    reg ready;
    assign end_step = (s < -3);
    reg start_mul;
    reg [7:0] a_for_cr, b_for_cr;

    mult mult_b (
        .clk(clk),
        .reset(reset),
        .start(start_mul),
        .a_bi(a_for_cr),
        .b_bi(b_for_cr),
        .busy_o(busy),
        .y_bo(b2)
    );
    assign busy = state;

    always @(posedge clk)
        if ( reset ) begin
            y <= 0;
            state <= IDLE;
            y_b <= 0;
            ready <= 1;
            start_mul <= 0;
        end else begin
            case ( state )
                IDLE: begin
                    if ( start && ready ) begin
                        state <= WORK;
                        y <= 0;
                        s <= 8 - 2;
                    end
                    start_mult <= 0; 
                    if (start) begin 
                        state <= WORK; 
                        x_b <= x_bi; 
                        m <= 1; 
                        res <= 1; 
                    end 
                end
                WORK: begin
                    if ( end_step ) begin
                        state <= IDLE;
                        y_b <= y;
                    end
                    y <= y << 1;
                    start_mul <= 1;
                    a_for_cr <= y + (y << 1);
                    b_for_cr <= y + 1;


                end
                WAIT_FOR_WORK: begin
                    start_mul <= 0;

                end
            endcase
        end

endmodule