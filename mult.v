
module mult (
    input               clk,
    input               reset,
    input [15:0]         a_bi,
    input [15:0]         b_bi,
    input               start,
    output [1:0]        busy_o,
    output reg  [15:0]  y_bo
);
    localparam IDLE = 2'b0;
    localparam WORK = 2'b1;    
    reg  [2:0]  ctr;
    wire [2:0]  end_step;
    wire [15:0]  part_sum;
    wire [15:0] shifted_part_sum;
    reg  [15:0]  a, b;
    reg  [15:0] part_res;
    reg         state;
    assign part_sum = a & {8{b [ ctr ] } };
    assign shifted_part_sum = part_sum << ctr;
    assign end_step = ( ctr == 3 'h7 );
    assign busy_o = state;
    always @(posedge clk )
        if ( reset ) begin
            ctr <= 0;
            part_res <= 0;
            y_bo <= 0;
            state <= IDLE;
        end else begin
            case ( state )
                IDLE: begin
                    if ( start ) begin
                        state <= WORK;
                        a <= a_bi;
                        b <= b_bi;
                        ctr <= 0;
                        part_res <= 0;
                    end
                end
                WORK:
                    begin
                        if ( end_step ) begin
                            state <= IDLE;
                            y_bo <= part_res;
                        end
                        part_res <= part_res + shifted_part_sum;
                        ctr <= ctr + 1;
                    end
            endcase
        end
endmodule