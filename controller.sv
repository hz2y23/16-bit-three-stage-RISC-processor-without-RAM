`include "opcodes.sv"  
`include "alucodes.sv" 
`include "constants.sv" 

module controller (
    input logic [`OP_CODE_LEN-1:0] opCode,  // Operation code input
	input logic BEQ, BLT, // the control signal from branch block
    output logic BranchEn,     // Enable signal for branching
    output logic [`EXE_CMD_LEN-1:0] EXE_CMD,  // ALU command signal
    output logic ImSel, Reg_W_En, IncreaseTK, BranchTK  // Control signals for various operations
);

 always_comb begin
        {BranchEn, EXE_CMD, ImSel, Reg_W_En, BranchTK} = 0;
		IncreaseTK = 1;
      case (opCode)
        // operations writing to the register file
        `ADD: 		begin 	EXE_CMD = `EXE_ADD; 	Reg_W_En = 1; end
        `SUB: 		begin 	EXE_CMD = `EXE_SUB; 	Reg_W_En = 1; end
		`AND:		begin	EXE_CMD = `EXE_AND;		Reg_W_En = 1; end
		`SLL:		begin 	EXE_CMD = `EXE_SLL;		Reg_W_En = 1; end
		`SRL:		begin 	EXE_CMD = `EXE_SRL;		Reg_W_En = 1; end
		`XOR:		begin 	EXE_CMD = `EXE_XOR;		Reg_W_En = 1; end
		`OR:		begin 	EXE_CMD = `EXE_OR;		Reg_W_En = 1; end
        // operations using an immediate value embedded in the instruction
        `ADDI: 		begin	EXE_CMD = `EXE_ADD;		ImSel = 1;		Reg_W_En = 1; end
        `SLLI: 		begin 	EXE_CMD = `EXE_SLL; 	ImSel = 1;		Reg_W_En = 1; end
        `SRLI: 		begin 	EXE_CMD = `EXE_SRL; 	ImSel = 1;		Reg_W_En = 1; end
		`ANDI:		begin	EXE_CMD = `EXE_AND;		ImSel = 1;		Reg_W_En = 1; end
		`XORI:		begin 	EXE_CMD = `EXE_XOR; 	ImSel = 1;		Reg_W_En = 1; end
		`ORI:		begin 	EXE_CMD = `EXE_OR; 	ImSel = 1;		Reg_W_En = 1; end
        // branch operations
        `BEQ: 		begin 	BranchEn = 1; 	if (BEQ) begin		IncreaseTK = 0;		BranchTK = 1; end end
        `BLT: 		begin 	BranchEn = 1;	if (BLT) begin 	 	IncreaseTK = 0;		BranchTK = 1; end end
		// jump operations
        `J: 		begin 	BranchTK = 1; 	IncreaseTK = 0; 	BranchTK = 1;end
		default: 	begin {BranchEn, EXE_CMD, ImSel, Reg_W_En, BranchTK} = 0; IncreaseTK = 1; end
      endcase
    end
endmodule // controller