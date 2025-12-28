`timescale 1ns / 1ps

module SignExtender #(
        parameter   INPUT_WIDTH  = 128,
        parameter   OUTPUT_WIDTH = 128,
        parameter   CHUNK_SIZE = 8,
        parameter   EN_BITS = 3,
        parameter   NUM_CHUNKS = INPUT_WIDTH / CHUNK_SIZE
    )
    (
        input   [INPUT_WIDTH - 1 :0]  data_in,
        input   reg [EN_BITS - 1 : 0]     en_bits,
        output  reg [OUTPUT_WIDTH - 1 :0] data_out
    );

    integer i, j, n_bits;

    always @(*) begin
        j = INPUT_WIDTH;
        data_out <= 0; // initialize output to 0
        n_bits = en_bits + 1; // add 1 for sign bit
        // save each chunk to a register
        for (i = NUM_CHUNKS; i > 0; i = i - 1) begin
            data_out[i*CHUNK_SIZE - 1 -: 8] <= $signed(data_in[j - 1 -: 8]) >>> (CHUNK_SIZE - n_bits);
            j = j - n_bits;
        end
    end

endmodule // SignExtender
