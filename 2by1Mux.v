`timescale 1ns / 1ps
module MUX_2_1 #(
    parameter    INPUT_WIDTH  = 8,
    parameter    OUTPUT_WIDTH = 8
) (
    input                           sel,
    input  [INPUT_WIDTH - 1 : 0]    a,b,
    output reg [OUTPUT_WIDTH - 1 : 0]   out
);

always @( a or b or sel) begin
    case (sel)
        0: out <= a;
        1: out <= b;
    endcase
end

endmodule  //2to1MUX