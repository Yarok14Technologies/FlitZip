module CompMAX #(
        parameter    INPUT_WIDTH  = 8,
        parameter    OUTPUT_WIDTH = 8
    ) (
        input  [INPUT_WIDTH - 1 : 0]    in_a,in_b,
        output [OUTPUT_WIDTH - 1 : 0]   data_out
    );

    assign data_out = in_a > in_b ? in_a : in_b;


endmodule  //module_name

