module imm_gen
(
         input logic[31:0] instruction,
         output logic[31:0] extended_imm,
         output logic[31:0] extended_load,
         output logic[31:0] extended_store,
         output logic[31:0] extended_branch,
         output logic[31:0] extended_LUI,
         output logic[31:0] extended_AUIP,
         output logic[31:0] extended_JAL,
         output logic[31:0] extended_JALR
);
    
    logic [6:0]opcode;
    assign opcode = instruction[6:0];
    
    
    always_comb begin 
        
    case (opcode)
      7'b0010011: extended_imm = {{20{instruction[31]}}, instruction[31:20]};  // I-type instructions (12-bit immediate, sign-extended to 32 bits)
      7'b0100011: extended_store = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};  // S-type instructions (12-bit immediate, sign-extended to 32 bits)
      7'b0000011: extended_load = {{20{instruction[31]}}, instruction[31:20]};  // Load-type instructions (12-bit immediate, sign-extended to 32 bits)
      7'b1100011: extended_branch = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // B-type instructions (Branch) 12-bit immediate, sign-extended
      7'b0110111: extended_LUI = {instruction[31:12], 12'b0};  // LUI instructions (20-bit immediate, extended to 32 bits)
      7'b0010111: extended_AUIP = {instruction[31:12], 12'b0};  //AUIPC instruction
      7'b1101111: extended_JAL = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};  // J-type JAL
      7'b1100111: extended_JALR = {{20{instruction[31]}}, instruction[31:20]};  // J-type JALR
      default begin
        extended_imm    = 32'b0;
        extended_load   = 32'b0;
        extended_store  = 32'b0;
        extended_branch = 32'b0;
        extended_AUIP   = 32'b0;
        extended_LUI    = 32'b0;
        extended_JAL    = 32'b0;
        extended_JALR   = 32'b0;
      end
    endcase
    
    end
    
    
endmodule