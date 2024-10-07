`include "constants.sv"

module IDStage (
    input logic clk,
    input logic [`INST_LEN-1:0] Instruction_IN, PC_IN,
	input logic [`INST_LEN-1:0] RD1,
    input logic [`INST_LEN-1:0] RD2,
	output logic IncreaseTK,
	output logic BranchTK,
	output logic Reg_W_En,
    output logic [`EXE_CMD_LEN-1:0] EXE_CMD,
    output logic ImSel,
    output logic [`INST_LEN-1:0] Instruction, PC, IMMG
);

    logic BEQ, BLT, BranchEn;

    // Instantiating controller unit
    controller u_controller(
	    // INPUT
        .opCode(Instruction_IN[15:12]),
		.BEQ(BEQ),
		.BLT(BLT),
		// OUTPUT
		.BranchEn(BranchEn),
        .EXE_CMD(EXE_CMD),
        .ImSel(ImSel),
        .Reg_W_En(Reg_W_En),
		.IncreaseTK(IncreaseTK),
		.BranchTK(BranchTK)
    );

	// Branch Comparator
		branch branch_inst(
		.a(RD1),
		.b(RD2),
		.BranchEn(BranchEn),
		.BEQ(BEQ),
		.BLT(BLT)
	);
	
    // IMM Geration
    ImmGen  #(.WIDTH(`WORD_LEN)) ImmGen_inst(
        .Instruction(Instruction_IN),
        .ImmG(IMMG)
    );

	assign Instruction = Instruction_IN;
	assign PC = PC_IN;
	
endmodule // IDStage
