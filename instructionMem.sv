`include "constants.sv" 

module instructionMem (
    input logic nReset,
    input logic [`WORD_LEN-1:0] Addr,
    output logic [`WORD_LEN-1:0] Instruction
);
  logic [$clog2(`INSTR_MEM_SIZE)-1:0] address;
  logic [`MEM_CELL_SIZE-1:0] instMem [0:`INSTR_MEM_SIZE-1];
  
  assign address [$clog2(`INSTR_MEM_SIZE)-1:0] = Addr[$clog2(`INSTR_MEM_SIZE)-1:0];
  
always_comb
    if (!nReset) begin
        // Initialize each byte of Instruction memory on reset
		//int A = 0;
		//int B = 1;
		//while (A < x) {
		//A = A * 2 + B;  // Update A based on B
		//B = B << 1;  // Left shift B by 1	}

        instMem[0] = 8'b0000_000_1; 		// ADDI %0, 6'b111111, %1;	R1 = SW
        instMem[1] = 8'b11111_001;

        instMem[2] = 8'b0000_000_0; 		// ADDI %0, 1, %3;			B = 1
        instMem[3] = 8'b00001_011;
		
        instMem[4] = 8'b0100_001_0;			// BLT %1, %2, 8;			if R1 < R2, PC = PC + 8
        instMem[5] = 8'b10_001000;
	
		instMem[6] = 8'b0000_0000; 			// NOOP
        instMem[7] = 8'b0000_0000;
		
        instMem[8] = 8'b0111_010_0;			//SLLI %2, 1, %2;			R2 = R2 << 1
        instMem[9] = 8'b00001_010;
		
		instMem[10] = 8'b0000_0000; 		// NOOP
        instMem[11] = 8'b0000_0000;

        instMem[12] = 8'b0010_010_0;		//ADD %2, %3, %2;			R2 = R3 + R2
        instMem[13] = 8'b11_000_010;

        instMem[14] = 8'b0111_011_0;		//SLLI %3, 1, %3;			R3 = R3 << 1
        instMem[15] = 8'b00001_011;
		
        instMem[16] = 8'b1100_1111;			//JUMP -6;					PC += -6
        instMem[17] = 8'b1111_1010;
		
		instMem[18] = 8'b0000_0000; 		// NOOP
        instMem[19] = 8'b0000_0000;
		
        instMem[20] = 8'b0000_011_1; 		// ADDI %3, 6'b111111, %0;	LED = R3
        instMem[21] = 8'b11111_000; 
	 
    end

  assign Instruction = {instMem[address], instMem[address + 1]};
endmodule // insttructionMem
