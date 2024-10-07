

module Register_output #(
    parameter integer LENGTH = 16  // Parameter for the bit-width of the register
) (
    input logic clk,
    input logic nReset,
    input logic [LENGTH-1:0] RegIn,
	input logic [LENGTH-1:0] ALU_result,
    output logic [LENGTH-1:0] RegOut
);
    // Synchronous nReset and write enable functionality
    always_ff @(posedge clk or negedge nReset) begin
        if (!nReset)
            RegOut <= 16'd0;
        else if (ALU_result == 16'hFFFF)
            RegOut <= RegIn;  // Write new value if ALU_result == 16'hFFFF
    end

endmodule // register