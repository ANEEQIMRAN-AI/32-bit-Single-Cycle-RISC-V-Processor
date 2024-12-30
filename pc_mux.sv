module Pc_mux(
    input logic [31:0] Alu_Result,
    input logic [31:0] pc_out,
    input logic        branch_taken,
    input logic        jump_en,
    output logic [31:0] pc_mout

);

always_comb begin
    if (branch_taken || jump_en ) begin
        pc_mout = Alu_Result;  // Use the ALU result for branch, jal, or jalr
    end else begin
        pc_mout = pc_out + 32'd4 ;    // Use Pc_New for sequential PC
    end
end

endmodule
