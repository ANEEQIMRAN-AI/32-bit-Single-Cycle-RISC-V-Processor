module Mux4X1(
    input logic [1:0] w_sel,
    input logic [31:0] Alu_Res,
    input logic [31:0] Dat_Res,
    input logic [31:0] pc_out,
    output logic [31:0] Writeback_data

);

always_comb begin
    case (w_sel)
        2'b00:   Writeback_data = Alu_Res;  // ALU result
        2'b01:   Writeback_data = Dat_Res;  // Memory read data
        2'b10:   Writeback_data = pc_out + 32'd4;
        default: Writeback_data = 32'b0;
    endcase
end
endmodule