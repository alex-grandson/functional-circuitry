module sqrt(
    input clk_i,
    input rst_i,
    input start_i,
    input [17:0] x_bi,
    output reg [8:0] y_bo,
    output busy_o
);
    localparam IDLE = 2'h0;
    localparam WORK = 2'b01;
    localparam RECALC_X = 2'b10;
    reg [17:0] x;
    reg [17:0] part_result;
    reg [17:0] b;
    reg [16:0] m;
    reg [1:0] state;
    wire end_step; 
    wire x_above_b;
    assign end_step = (m == 0);
    assign busy_o = |state;
    assign x_above_b = x>=b;
    always @(posedge clk_i)
        if (rst_i) begin
            y_bo <= 0;
            b <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if (start_i) begin
                        state <= WORK;
                        part_result <= 0;
                        x <= x_bi;
                        m <= 1 << 16;
                    end
                WORK:
                    begin
                        if (!end_step) begin
                           b <= part_result | m;
                           part_result <= part_result >> 1;
                           state <= RECALC_X; 
                        end else begin
                            y_bo <= part_result[8:0];    
                            state <= IDLE;
                        end     
                    end
                RECALC_X:
                    begin
                        if(x_above_b) begin
                            x <= x - b;
                            part_result <= part_result | m;
                        end
                        m <= m >> 2;
                        state <= WORK;
                    end    
            endcase
        end    
endmodule