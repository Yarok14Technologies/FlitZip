module bitstrip #(
        parameter   INPUT_WIDTH  = 128,
        parameter   OUTPUT_WIDTH = 128,
        parameter   CHUNK_SIZE = 8,
        parameter   EN_BITS = 3,
        parameter   NUM_CHUNKS = INPUT_WIDTH / CHUNK_SIZE
    ) (
        input  [EN_BITS -1 : 0]             en_bits,
        input  reg [INPUT_WIDTH - 1 : 0]    deltas_in,
        output reg [OUTPUT_WIDTH - 1 : 0]   data_out
    );

    integer i, j, n_bits;

    always @(en_bits, deltas_in) begin
        if (en_bits <= 3'b111) begin
            j = INPUT_WIDTH;
            data_out <= 0; // initialize output to 0
            n_bits = en_bits; // add 1 for sign bit
            // save each chunk to a register
            for (i = NUM_CHUNKS; i > 0; i = i - 1) begin
                data_out[j - 1 -: 8] <= deltas_in[i*CHUNK_SIZE - 1 -: 8] << (CHUNK_SIZE - n_bits);
                j = j - n_bits;
            end
        end
        else
            data_out <= 128'bz; // pass through
    end




endmodule  //bitstrip
