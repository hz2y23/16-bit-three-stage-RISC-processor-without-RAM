module regFile #(
    parameter integer ADDR_LEN = 3,  // Number of bits for the register address
    parameter integer DATA_WIDTH = 16, // Data width of registers
    parameter integer REG_FILE_SIZE = 8 // Total number of registers
) (
    input logic clk,
    input logic nReset,
    input logic Reg_W_En,
    input logic [ADDR_LEN-1:0] Rs1, Rs2, Rd,
    input logic [DATA_WIDTH-1:0] writedata,
    output logic [DATA_WIDTH-1:0] RD1, RD2
);

    logic [DATA_WIDTH-1:0] regMem [0:REG_FILE_SIZE-1]; // Register memory array

    always_ff @(posedge clk or negedge nReset) begin
        if (!nReset) begin
            for (integer i = 0; i < REG_FILE_SIZE; i = i + 1) begin
                regMem[i] <= 0;
            end
        end else if (Reg_W_En && Rd != 0) begin  // Protect register 0 from being written to
            regMem[Rd] <= writedata;
        end
    end

    // Read data from registers
    always_comb
		begin
			RD1 = regMem[Rs1];
			RD2 = regMem[Rs2];
		end

endmodule