module mux #(
    parameter integer LENGTH = 16  // Default width of 32 bits
) (
    input logic sel,
    input logic [LENGTH-1:0] in1, in2,
    output logic [LENGTH-1:0] out
);

    // Select input based on sel signal
    assign out = sel ? in2 : in1;

endmodule // mux
