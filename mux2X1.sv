module mux(
    input logic [31:0] R_type,
    input logic [31:0] I_type,
    input logic [6:0]  opcode,
    input logic [31:0] extended_store,    // S-type immediate
    input logic [31:0] extended_load,    // L-type immediate
    input logic [31:0] extended_branch,  // B-type immediate
    input logic [31:0] extended_LUI,     // LUI-type immediate
    input logic [31:0] extended_AUIP,    // AUIP-type immediate
    input logic [31:0] extended_JAL,
    input logic [31:0] extended_JALR,
    input logic         sel_b,
    output logic [31:0] opr_b

);
  always_comb begin
    if (sel_b) begin
      case (opcode)
      7'b0010011: opr_b = I_type;
      7'b0000011: opr_b = extended_load;
      7'b0100011: opr_b = extended_store;
      7'b1100011: opr_b = extended_branch;
      7'b0110111: opr_b = extended_LUI;
      7'b0010111: opr_b = extended_AUIP;
      7'b1101111: opr_b = extended_JAL;
      7'b1100111: opr_b = extended_JALR;
      default:    opr_b = 32'b0;
      endcase
    end
    else begin
        opr_b = R_type;
    end
  end
endmodule