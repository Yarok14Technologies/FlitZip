`timescale 1ns / 1ps

module compressor #(
        parameter   INPUT_WIDTH  = 128,
        parameter   OUTPUT_WIDTH = 128,
        parameter   CHUNK_SIZE = 8,
        parameter   EN_BITS = 3,
        parameter   NUM_CHUNKS = INPUT_WIDTH / CHUNK_SIZE
    ) (
        input                               clk_in, is_head, // clock, signals from control logic
        input  [INPUT_WIDTH - 1 : 0]        data_in, // input flit
        output [OUTPUT_WIDTH - 1 : 0]       data_out, // compressed flit
        output [EN_BITS - 1 : 0]            en_out // encoding bits for each flit
    );
    wire [INPUT_WIDTH - 1 : 0]  delta_out;
    wire [CHUNK_SIZE - 1 : 0] Clarge, Csmall, sb0_out, mux_out, base;
    wire [EN_BITS - 1 : 0] en_bits;
    wire sel_bit;


    assign base = (Clarge + Csmall)/2; // Base flit
    assign en_out = en_bits; // Encode bits

    // if (is_head == 1'b1) begin
    //     // if flit type is head, then no output for compressor
    //     assign data_out = 128'bz; // high impedance
    //     //head_buffer <= data_in; // store head flit for adding metadata
    // end

    // else if(is_head == 1'b0) begin

    //     if (en_bits == 3'b000)
    //         assign data_out = 128'bz; // if all chunks are same, high impedence
    // end

    minmax minmx (
               .input_data(data_in),
               .max_data(Clarge),
               .min_data(Csmall)
           );

    subtractor sb0 (
                   .a(base),
                   .b(Clarge),
                   .data_out(sb0_out)
               ); // Subtract the maximum value from the base value

    priority_encoder p_enc(
                         .data_in(sb0_out),
                         .code_out(en_bits)
                     ); // Encode the difference between the base and maximum values

    small_comb comb_logic(
                   .data_in(en_bits),
                   .data_out(sel_bit)

               ); // Generate the select bit to be sent to the MUX

    MUX_2_1 vec_mux(
                .b(base),
                .a(8'b00000000),
                .out(mux_out),
                .sel(sel_bit)
            ); // MUX to select the correct value to be sent to the subtractor

    bitstrip bs(
                 .en_bits(en_bits), // add the sign bit
                 .deltas_in(delta_out),
                 .data_out(data_out)
             ); // Removes extra bits from the data

    // Parallel Subtractors
    genvar i;

    generate // generate the parallel subtractors
        for(i = 0; i < NUM_CHUNKS; i = i+1 ) begin
            subtractor SUBi(
                           .a(data_in[i*CHUNK_SIZE +: CHUNK_SIZE]),
                           .b(mux_out),
                           .data_out(delta_out[i*CHUNK_SIZE +: CHUNK_SIZE])
                       );
        end
    endgenerate


endmodule  //compressor
