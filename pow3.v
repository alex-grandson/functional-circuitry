module pow3 (
    input clk_i ,
    input rst_i ,
    
    input [ 7 : 0 ] a_bi ,
    input start_i ,
    
    output busy_o ,
    output reg out_ready,
    output reg [23:0] y_bo
) ;
    localparam IDLE = 2'h0;
    localparam WORK = 2'h1;
    localparam WORK_1 = 2'h3;
    reg [2:0] ctr;
    wire [2:0] end_step;
    wire [7:0] part_sum;
    wire [15:0] shifted_part_sum;
    reg [7:0] a, b;
    reg [15:0] part_res;
    reg [1:0] state;
    initial out_ready = 0;
    assign part_sum = a&{8{b[ctr]}};
    assign shifted_part_sum = part_sum << ctr;
    assign end_step = (ctr == 3'h7);
    assign busy_o = state[0];
    always @(posedge clk_i )
        if ( rst_i ) begin
            ctr <= 0 ;
            part_res <= 0 ;
            y_bo <= 0 ;
            state <= IDLE ;
        end else begin
            case (state)
            IDLE :
                if ( start_i ) begin
                    state <= WORK;
                    a <= a_bi ;
                    b <= a_bi ;
                    ctr <= 0 ;
                    part_res <= 0 ;
                end
            WORK:
                begin
                    if ( end_step ) begin
                        state <= WORK_1 ;
                        a <= a_bi ;
                        b <= part_res ;
                        ctr <= 0 ;
                        y_bo <= part_res;
                        part_res = 0 ;
                    end
                    part_res <= part_res + shifted_part_sum;
                    ctr <= ctr + 1 ;
                end
            WORK_1:
                begin
                    if ( end_step ) begin
                        state <= IDLE ;
                        y_bo <= part_res;
                        out_ready <= 1;
                    end
                    part_res <= part_res + shifted_part_sum;
                    ctr <= ctr + 1 ;
                end
            endcase
        end
endmodule