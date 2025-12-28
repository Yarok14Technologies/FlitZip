// Module to count number of bit ones in a binary number
module en_table #(
        parameter INPUT_WIDTH = 3
    )(
        input           [INPUT_WIDTH - 1 :0] en_bits,
        output reg         [7:0] count

    );

    always @(en_bits) begin
        count = 0;  //initialize count variable.
        case(en_bits)
            3'b000:
                count = 8'd0;

            3'b010:
                count = 8'd32;

            3'b011:
                count = 8'd48;

            3'b100:
                count = 8'd64;

            3'b101:
                count = 8'd80;

            3'b110:
                count = 8'd96;

            3'b111:
                count = 8'd112;


            default:
                count = 8'd128;

        endcase

    end


endmodule // en_table
