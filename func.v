module func (
    input wire clk_i, 
    input rst_i, 
    input start_i, 
    input [7:0] a,
    input [7:0] b, 
    input wire in_ready,
    output reg out_ready, 
    output reg [23:0] out
);
    localparam S0 = 0,
                S1 = 1,
                S2 = 2,
                S3 = 3,
                S4 = 4;
    reg [7:0] pow_in;
    wire [23:0] pow_out;
    reg pow_rst;
    reg pow_in_ready;
    wire pow_out_ready;

    reg [7:0] mult_a, mult_b;
    wire [15:0] mult_out;
    reg mult_rst;
    wire        mult_busy; 
    reg         mult_start; 

    reg [2:0] state = S0;
    
    reg [15:0] adder_a;
    reg [23:0] adder_b;
    wire [24:0] adder_out;

    adder summ(
        .a(adder_a),
        .b(adder_b),
        .out(adder_out)
    );

    pow3 pow3_instance (
        .clk_i(clk_i), 
        .rst_i(pow_rst), 
        .a_bi(pow_in), 
        .start_i(start_i), 
        // .busy_o(busy), 
        .y_bo(pow_out),
        .out_ready(pow_out_ready)
    );

    mult mult_instance (
        .clk(clk_i), 
        .reset(mult_rst), 
        .a_bi(mult_a), 
        .b_bi(mult_b), 
        .start(mult_start), 
        // .busy_o(busy), 
        .y_bo(mult_out),
        .out_ready(mult_out_ready)
    );
always @(posedge clk_i) begin
    case (state)
        S0: begin
            if (in_ready) begin
                mult_a <= a;
                mult_b <= b;
                // pow_out <= 0;
                pow_in <= b;
                state <= S1;
                out_ready <= 0;
            end
            
        end
        S1: begin
            mult_rst <= 0;
            state <= S2;
            // in_ready <= 0;
        end 
        S2: begin
            if (mult_out_ready) begin
                mult_start <= 0;
                adder_a <= mult_out;
                state <= S3;
            end
        end
        S3: begin
            if (pow_out_ready) begin
                adder_b <= pow_out;
                state <= S4;
            end 
        end
        S4: begin
            out <= adder_out;
            out_ready <= 1;
            state <= S0;
            
        end 
    endcase
end

endmodule

