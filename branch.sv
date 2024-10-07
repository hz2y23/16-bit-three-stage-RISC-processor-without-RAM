
module branch #(parameter n =16) ( //8 bit processor
	input logic [n-1:0] a, b, // input operands
	input logic BranchEn,
	output logic BEQ, BLT  // comparison result
);
	
// Calculate BEQ and BLT
always_comb
begin

if (a == b && BranchEn)
	BEQ = 1'b1;
else
	BEQ = 1'b0;
end

always_comb
begin
if (a < b && BranchEn)
	BLT = 1'b1;
else
	BLT = 1'b0;
end
	
endmodule