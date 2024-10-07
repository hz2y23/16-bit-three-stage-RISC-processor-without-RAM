`include "constants.sv"  

module IFStage (
    input logic clk,
    input logic nReset,
    input logic BranchTK, IncreaseTK,
    input logic [`WORD_LEN-1:0] Broffset,
    output logic [`WORD_LEN-1:0] PC,
    output logic [`WORD_LEN-1:0] Instruction
);
    // Internal signals
    logic [`WORD_LEN-1:0] Increase_or_not, Increase, Branch_or_Increase, regIn, Address;
	logic Increase_TK;
    // Register to hold the PC
    register #(.WIDTH(`WORD_LEN)) PCReg (
        .clk(clk),
        .nReset(nReset),
        .regIn(regIn),
        .regOut(Address)
    );
	
    // Adder to calculate the next PC address
    adder #(.WIDTH(`WORD_LEN)) add1 (
        .in1(16'd2),
        .in2(Address),
        .out(Increase)
    );
	
	// Multiplexer for choosing between increment by 2 and branch offset
    mux #(.LENGTH(`WORD_LEN)) mux0 (
        .in1(Address),
        .in2(Increase),
        .sel(IncreaseTK),
        .out(Increase_or_not)
    );
	
    // Multiplexer for choosing between increment by 2 and branch offset
    mux #(.LENGTH(`WORD_LEN)) mux1 (
        .in1(Increase_or_not),
        .in2(Broffset),
        .sel(BranchTK),
        .out(regIn)
    );
	
    // Instruction Memory fetches Instruction at current PC
    instructionMem u_instructionMem (
        .nReset(nReset),
        .Addr(Address),
        .Instruction(Instruction)
    );
	
	assign PC = Address;
	
endmodule // IFStage