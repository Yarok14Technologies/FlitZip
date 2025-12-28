`timescale 1ns / 1ps

module subtractor #(
    parameter    INPUT_WIDTH  = 8,
    parameter    OUTPUT_WIDTH = 8
) (
    input  [INPUT_WIDTH - 1 : 0]    a,b,
    output [OUTPUT_WIDTH - 1 : 0]   data_out
);

    assign data_out = b - a;

endmodule  //subtractor