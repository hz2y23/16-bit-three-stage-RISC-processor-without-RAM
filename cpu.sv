`include "constants.sv"
`include "opcodes.sv"  
`include "alucodes.sv"  

module cpu (
    input logic clk, 
    input logic nReset,
	input logic [`INST_LEN-1:0] SW,
	output logic [`INST_LEN-1:0] LED
);
    logic [`WORD_LEN-1:0] PC_IF, PC_ID, PC_ID2EXE, PC_EXE;
    logic [`WORD_LEN-1:0] Inst_IF, Inst_ID, Inst_ID2EXE, Inst_EXE;
    logic [`WORD_LEN-1:0] RD1_ID, RD2_ID, RD1_EXE, RD2_EXE;
    logic [`WORD_LEN-1:0] ALUa_EXE;
    logic [`WORD_LEN-1:0] ALUb_EXE;
    logic [`WORD_LEN-1:0] ALURes_EXE;
    logic [`WORD_LEN-1:0] dataMem_out_EXE;
    logic [`WORD_LEN-1:0] WB_result;
	logic [`WORD_LEN-1:0] IMMG_ID,IMMG_EXE;
	logic [`WORD_LEN-1:0] Broffset_EXE;
    logic [`REG_FILE_ADDR_LEN-1:0] Rd_EXE;
    logic [`REG_FILE_ADDR_LEN-1:0] Rs1_ID, Rs2_ID;
    logic [`EXE_CMD_LEN-1:0] EXE_CMD_ID, EXE_CMD_EXE;
	logic IncreaseTK_ID;
    logic BranchTK_ID, BranchTK_EXE, BranchTK_EXE2IF;
	logic Reg_W_EN_ID, Reg_W_EN_EXE, Reg_W_EN_EXE2IF;
    logic ImSel_ID, ImSel_EXE;

    // Instances of other modules remain unchanged but ensure proper port connection as per SystemVerilog best practices.
	regFile regFile_inst(
		// INPUTS
		.clk(clk),
		.nReset(nReset),
		.Rs1(Inst_ID[11:9]),
		.Rs2(Inst_ID[8:6]),
		.Rd(Rd_EXE),
		.writedata(WB_result),
		.Reg_W_En(Reg_W_EN_EXE2IF),
		// OUTPUTS
		.RD1(RD1_ID),
		.RD2(RD2_ID)
	);

	//###########################
	//##### PIPLINE STAGES ######
	//###########################

	IFStage IFStage_inst (
		// INPUTS
		.clk(clk),
		.nReset(nReset),
		.IncreaseTK(IncreaseTK_ID),
		.BranchTK(BranchTK_EXE2IF),
		.Broffset(Broffset_EXE),
		// OUTPUTS
		.Instruction(Inst_IF),
		.PC(PC_IF)
	);
	
	
	//############################
	//#### PIPLINE REGISTERS #####
	//############################
	
	IF2ID IF2IDReg (
		// INPUTS
		.clk(clk),
		.nReset(nReset),
		.PC_In(PC_IF),
		.Instruction_IN(Inst_IF),
		// OUTPUTS
		.PC(PC_ID),
		.Instruction(Inst_ID)
	);

	//###########################
	//##### PIPLINE STAGES ######
	//###########################


	IDStage IDStage_inst (
		// INPUTS
		.clk(clk),
		.PC_IN(PC_ID),
		.Instruction_IN(Inst_ID),
		.RD1(RD1_ID),
		.RD2(RD2_ID),
		// OUTPUTS
		.IncreaseTK(IncreaseTK_ID),
		.BranchTK(BranchTK_ID),
		.Reg_W_En(Reg_W_EN_ID),
		.EXE_CMD(EXE_CMD_ID),
		.ImSel(ImSel_ID),
		.Instruction(Inst_ID2EXE),
		.PC(PC_ID2EXE),
		.IMMG(IMMG_ID)
	);

	//############################
	//#### PIPLINE REGISTERS #####
	//############################

	ID2EXE ID2EXEReg (
		// INPUTS
		.clk(clk),
		.nReset(nReset),
		.ImSel_IN(ImSel_ID),
		.Reg_W_En_IN(Reg_W_EN_ID),
		.BranchTK_IN(BranchTK_ID),
		.EXE_CMD_IN(EXE_CMD_ID),
		.PC_IN(PC_ID2EXE),
		.Instruction_IN(Inst_ID2EXE),
		.RD1_IN(RD1_ID),
		.RD2_IN(RD2_ID),
		.IMMG_IN(IMMG_ID),
		// OUTPUTS
		.ImSel(ImSel_EXE),
		.Reg_W_En(Reg_W_EN_EXE),
		.BranchTK(BranchTK_EXE),
		.EXE_CMD(EXE_CMD_EXE),
		.PC(PC_EXE),
		.Instruction(Inst_EXE),
		.IMMG(IMMG_EXE),
		.RD1(RD1_EXE),
		.RD2(RD2_EXE)
	);

	//###########################
	//##### PIPLINE STAGES ######
	//###########################
	
	EXEStage EXEStage_inst (
		// INPUTS
		.clk(clk),
		.nReset(nReset),
		.ImSel(ImSel_EXE),
		.SW(SW),
		.Reg_W_EN_IN(Reg_W_EN_EXE),
		.BranchTK_IN(BranchTK_EXE),
		.EXE_CMD(EXE_CMD_EXE),
		.RD1(RD1_EXE),
		.RD2(RD2_EXE),
		.Instruction(Inst_EXE),
		.PC(PC_EXE),
		.IMMG(IMMG_EXE),
		// OUTPUTS
		.Broffset(Broffset_EXE),
		.Wdata(WB_result),
		.Rd(Rd_EXE),
		.Reg_W_EN(Reg_W_EN_EXE2IF),
		.BranchTK(BranchTK_EXE2IF),
		.LED(LED)
	);

endmodule