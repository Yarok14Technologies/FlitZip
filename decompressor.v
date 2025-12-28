`timescale 1ns / 1ps

module decompressor #(
        parameter INPUT_WIDTH  = 128,
        parameter OUTPUT_WIDTH = 128,
        parameter CHUNK_SIZE = 8,
        parameter EN_BITS = 3,
        parameter NUM_CHUNKS = INPUT_WIDTH / CHUNK_SIZE

    ) (
        input                               clk_in,is_head,
        input  [INPUT_WIDTH - 1 : 0]        data_in, // compressed input data
        output [OUTPUT_WIDTH - 1 : 0]       data_out // decompressed output data
    );

    //wire [INPUT_WIDTH - 1 : 0] buff_out;
    // reg [(BE_PAIR*4) - 1 : 0] meta_data; // buffer for whole metadata
    // wire [BE_PAIR - 1 : 0]   meta; // signle base-encoding pair
    wire [INPUT_WIDTH - 1 : 0] sign_out;
    wire [CHUNK_SIZE - 1 : 0]  base, mux_out;
    wire [EN_BITS - 1 : 0] en_bits;
    wire sel_bit;


    integer count = 0; // flit counter
    // integer meta_count=43;


    // assign meta = meta_data[meta_count-:11];

    // assign en_bits = meta[10:8];
    // assign base = meta[7:0];

    SignExtender sign_ext(
                     .en_bits(en_bits),
                     .data_in(data_in),
                     .data_out(sign_out)
                 );

    small_comb comb_logic(
                   .data_in(en_bits),
                   .data_out(sel_bit)
               );

    MUX_2_1 vec_mux_d(
                .b(base),
                .a(8'b00000000),
                .out(mux_out),
                .sel(sel_bit)
            );

    // Parallel Subtractors
    genvar i;

    generate // generate the parallel subtractors
        for(i = 0;
                i < NUM_CHUNKS;
                i = i+1 ) begin
            subtractor SUBi(
                           .a(sign_out[i*CHUNK_SIZE +: CHUNK_SIZE]),
                           .b(mux_out),
                           .data_out(data_out[i*CHUNK_SIZE +: CHUNK_SIZE])
                       );
        end
    endgenerate



endmodule  //decompressor
