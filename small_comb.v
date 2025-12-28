`timescale 1ns / 1ps

module small_comb #(
    parameter    INPUT_WIDTH  = 3
) (

    input  [INPUT_WIDTH - 1 : 0]    data_in,
    output data_out
);

assign data_out = (data_in == 3'b111) ? 1'b0 : 1'b1;

endmodule  //small_comb