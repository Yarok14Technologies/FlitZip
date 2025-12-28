`timescale 1ns / 1ps
// 8:3 priority encoder
module priority_encoder #(
        parameter    INPUT_WIDTH  = 8,
        parameter    OUTPUT_WIDTH = 3
    )
    (
        input [INPUT_WIDTH - 1 :0]         data_in,
        output reg [OUTPUT_WIDTH - 1 :0]   code_out
    );

    always @(data_in) begin
        casez(data_in)
            // Higher priority
            8'b1???????:
                code_out = 3'b111;

            8'b01??????:
                code_out = 3'b111;

            8'b001?????:
                code_out = 3'b111;

            8'b0001????:
                code_out = 3'b110;

            8'b00001???:
                code_out = 3'b101;

            8'b000001??:
                code_out = 3'b100;

            8'b0000001?:
                code_out = 3'b011;

            8'b00000001:
                code_out = 3'b010;

            8'b00000000:
                code_out = 3'b000;

            default:
                code_out = 3'b000;

        endcase
    end

endmodule // priority_encoder
