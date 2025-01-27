`include "constants.sv"

module BranchGen (
    input logic [`INST_LEN-1:0] ImmG,
	input logic [`INST_LEN-1:0] PC,
    output logic [`INST_LEN-1:0] BrOffset
);

    assign BrOffset = (ImmG << 1) + PC;
endmodule // BranchGen
