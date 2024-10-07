`include "constants.sv"

module ID2EXE (
    input logic clk, nReset,
    input logic ImSel_IN, xSel_IN, Reg_W_En_IN, BranchTK_IN,
    input logic [`EXE_CMD_LEN-1:0] EXE_CMD_IN,
    input logic [`INST_LEN-1:0] PC_IN, Instruction_IN, 
	input logic [`WORD_LEN-1:0] IMMG_IN, RD1_IN, RD2_IN,
    output logic ImSel, xSel, Reg_W_En, BranchTK,
    output logic [`EXE_CMD_LEN-1:0] EXE_CMD,
	output logic [`INST_LEN-1:0] PC, Instruction, 
	output logic [`WORD_LEN-1:0] IMMG, RD1, RD2

);

    always_ff @(posedge clk or negedge nReset) begin
        if (!nReset) begin
			ImSel <= 0;
            Reg_W_En <= 0;
            EXE_CMD <= 0;
            PC <= 0;
			Instruction <= 0;
			RD1 <= 0;
			RD2 <= 0;
			IMMG <= 0;
			xSel <= 0;
			BranchTK <= 0;
			
        end else begin
			ImSel <= ImSel_IN;
            Reg_W_En <= Reg_W_En_IN;
            EXE_CMD  <= EXE_CMD_IN;
            PC <= PC_IN;
			Instruction <= Instruction_IN;
			RD1 <= RD1_IN;
			RD2 <= RD2_IN;
			IMMG <= IMMG_IN;
			xSel <= xSel_IN;
			BranchTK <= BranchTK_IN;
        end
    end
endmodule // ID2EXE
