
module register #(
    parameter integer WIDTH = 16  // Parameter for the bit-width of the register
) (
    input logic clk,
    input logic nReset,
    input logic [WIDTH-1:0] regIn,
    output logic [WIDTH-1:0] regOut
);
    // Synchronous nReset and write enable functionality
    always_ff @(posedge clk or negedge nReset) begin
        if (!nReset)
            regOut <= '0;
        else
            regOut <= regIn;
    end

endmodule