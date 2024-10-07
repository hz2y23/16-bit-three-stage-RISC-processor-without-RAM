module adder #(
    parameter integer WIDTH = 16 
) (
    input logic [WIDTH-1:0] in1, in2, 
    output logic [WIDTH-1:0] out  
);

    // Perform addition and assign to output
    assign out = in1 + in2;

endmodule
