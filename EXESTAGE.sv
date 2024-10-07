`include "constants.sv"

module EXEStage (
    input logic clk,
	input logic nReset,
	input logic ImSel,
	input logic Reg_W_EN_IN, BranchTK_IN,
    input logic [`EXE_CMD_LEN-1:0] EXE_CMD, 
	input logic [`WORD_LEN-1:0] RD1, RD2, 
	input logic [`WORD_LEN-1:0] SW,
	input logic [`WORD_LEN-1:0] Instruction, PC, IMMG, 
    output logic [`WORD_LEN-1:0] Broffset, Wdata, 
	output logic [`WORD_LEN-1:0] LED,
	output logic [`REG_FILE_ADDR_LEN-1:0] Rd,
	output logic Reg_W_EN, BranchTK
);

  logic [`WORD_LEN-1:0] ALUa, ALUb, ALU_result;
  logic [`Gen_LEN-1:0] offset;
   // Multiplexer for determining whether ALUb is from the reg file or the immediate value
    mux #(.LENGTH(`WORD_LEN)) mux3 (
        .in1(RD2),
        .in2(IMMG),
        .sel(ImSel),
        .out(ALUb)
    );
	
	// ALU operation based on the selected operands and execution command
	ALU u_ALU (
		.ALUa(RD1),
		.ALUb(ALUb),
		.EXE_CMD(EXE_CMD),
		.ALU_result(ALU_result)
	);
	
  
  // Branch Target Generation
    BranchGen u_BranchGen(
		.ImmG(IMMG),
		.PC(PC),
		.BrOffset(Broffset)
    );

    // Select data source for write-back stage
	    mux #(.LENGTH(`WORD_LEN)) mux4 (
        .in1(ALU_result),
        .in2(SW),
        .sel((ALU_result == 16'hFFFF)),
        .out(Wdata)
    );
	
	//register for output
		Register_output #(.LENGTH(`WORD_LEN)) Register_out (
		.clk(clk),
		.nReset(nReset),
		.RegIn(RD1),
		.ALU_result(ALU_result),
		.RegOut(LED)
	);

	assign Reg_W_EN = Reg_W_EN_IN;
	assign Rd = Instruction[2:0];
	assign BranchTK = BranchTK_IN;
endmodule // EXEStage
