module minmax #(
        parameter NUM_OF_BITS = 128,
        parameter NUM_OF_LEVELS = 4,
        parameter CHUNK_SIZE = 8,
        parameter EN_BITS = 3

    ) (

        input  [NUM_OF_BITS-1:0]     input_data,
        output [CHUNK_SIZE - 1 : 0]  min_data,
        output [CHUNK_SIZE - 1 : 0]  max_data

    );

    wire [13:0] [7:0] intconns_max, intconns_min; // set of 14 8-bit interconnects for the tree structure
    genvar i,j;
    generate
        for (i = 0; i < 16; i = i+2) begin : first_level
            comp_max max (
                         .in_a(input_data[i*CHUNK_SIZE+7:i*CHUNK_SIZE]),
                         .in_b(input_data[(i+1)*CHUNK_SIZE+7:(i+1)*CHUNK_SIZE]),
                         .data_out(intconns_max[i/2])
                     );
        end
    endgenerate

    generate
        for(i=0; i < 8; i=i+2) begin : sec_level

            comp_max max (
                         .in_a(intconns_max[i]),
                         .in_b(intconns_max[i+1]),
                         .data_out(intconns_max[(i/2) + 8])
                     );

        end
    endgenerate

    generate
        for(i=0;i < 4; i=i+2) begin : third_level

            comp_max max (
                         .in_a(intconns_max[(i/2) + 8]),
                         .in_b(intconns_max[((i/2) + 8) + 1]),
                         .data_out(intconns_max[(i/2) + 12])
                     );

        end

    endgenerate

    generate
        for(i=0;i < 2; i=i+2) begin : fourth_level

            comp_max max (
                         .in_a(intconns_max[(i/2) + 12]),
                         .in_b(intconns_max[((i/2) + 12) + 1]),
                         .data_out(max_data)
                     );
        end
    endgenerate

    // generate min values

    generate
        for (i = 0; i < 16; i = i+2) begin
            comp_min min (
                         .in_a(input_data[i*CHUNK_SIZE+7:i*CHUNK_SIZE]),
                         .in_b(input_data[(i+1)*CHUNK_SIZE+7:(i+1)*CHUNK_SIZE]),
                         .data_out(intconns_min[i/2])
                     );
        end
    endgenerate

    generate
        for(i=0; i < 8; i=i+2) begin

            comp_min min (
                         .in_a(intconns_min[i]),
                         .in_b(intconns_min[i+1]),
                         .data_out(intconns_min[(i/2) + 8])
                     );

        end
    endgenerate

    generate
        for(i=0;i < 4; i=i+2) begin

            comp_min min (
                         .in_a(intconns_min[(i/2) + 8]),
                         .in_b(intconns_min[((i/2) + 8) + 1]),
                         .data_out(intconns_min[(i/2) + 12])
                     );

        end

    endgenerate

    generate
        for(i=0;i < 2; i=i+2) begin

            comp_min min (
                         .in_a(intconns_min[(i/2) + 12]),
                         .in_b(intconns_min[((i/2) + 12) + 1]),
                         .data_out(min_data)
                     );
        end
    endgenerate



endmodule  //minmax
