`include "constants.sv"

module IF2ID (
    input logic clk,
    input logic nReset,
    input logic [`INST_LEN-1:0] PC_In, Instruction_IN,
    output logic [`INST_LEN-1:0] PC, Instruction
);

    // Pipeline register control for fetch to decode stage
    always_ff @(posedge clk or negedge nReset) begin
        if (!nReset) begin
            // Reset the output values
            PC <= 0;
            Instruction <= 0;
            end else begin
                // Normal operation, pass values from input to output
                Instruction <= Instruction_IN;
                PC <= PC_In;
            end
    end

endmodule // IF2ID
