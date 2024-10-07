
 `include "opcodes.sv"
module ImmGen #(parameter WIDTH = 16) (
    input logic [WIDTH-1:0] Instruction,
    output logic [WIDTH-1:0] ImmG);


always_comb
    case(Instruction[15:12])
        `ADDI: ImmG = {{10{Instruction[8]}}, Instruction[8:3]};
		`SLLI: ImmG = {10'b0, Instruction[8:3]};
		`SRLI: ImmG = {10'b0, Instruction[8:3]};
		`BEQ:  ImmG = {{10{Instruction[5]}}, Instruction[5:0]};
		`BLT:  ImmG = {{10{Instruction[5]}}, Instruction[5:0]};
		`J:    ImmG = {{4{Instruction[11]}}, Instruction[11:0]};
        default:                     
            ImmG = {32'b0};
    endcase
    
endmodule
 