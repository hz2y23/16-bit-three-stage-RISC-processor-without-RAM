`include "alucodes.sv"  
`include "constants.sv"

module ALU (
    input logic [`WORD_LEN-1:0] ALUa, ALUb,
    input logic [`EXE_CMD_LEN-1:0] EXE_CMD,
    output logic [`WORD_LEN-1:0] ALU_result
);
logic overflow;
    always_comb 
	begin
	ALU_result = 0;
	overflow = 0;
        case (EXE_CMD)
            `EXE_ADD: begin {overflow, ALU_result} = ALUa + ALUb; 
				if (overflow) 
					ALU_result = 16'hFFFF; 
				end
            `EXE_SUB: 	ALU_result = ALUa - ALUb;
			`EXE_AND:	ALU_result = ALUa & ALUb;
			`EXE_OR:	ALU_result = ALUa | ALUb;
			`EXE_XOR:	ALU_result = ALUa ^ ALUb;
            `EXE_SLL: 	ALU_result = ALUa << ALUb;
            `EXE_SRL: 	ALU_result = ALUa >> ALUb;
            default: ALU_result = 16'b0;
        endcase
    end

endmodule
