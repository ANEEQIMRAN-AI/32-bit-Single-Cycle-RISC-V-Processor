module alu
(
    input  logic [31:0] opr_a,
    input  logic [31:0] opr_b,
    input  logic [3: 0] aluop,
    input  logic [31:0] pc_out,
    output logic [31:0] opr_res
);

    always_comb
    begin
        case (aluop)
            4'b0000: opr_res = opr_a + opr_b;                     // ADD (also used for Load/Store address)// AUIPC: Add immediate to PC
            4'b0001: opr_res = opr_a - opr_b;                     // SUB
            4'b0010: opr_res = opr_a << opr_b[4:0];               // SLL
            4'b0011: opr_res = ($signed(opr_a) < $signed(opr_b)) ? 32'b1 : 32'b0;  // SLT
            4'b0100: opr_res = (opr_a < opr_b) ? 32'b1 : 32'b0;   // SLTU
            4'b0101: opr_res = opr_a ^ opr_b;                     // XOR
            4'b0110: opr_res = opr_a >> opr_b[4:0];               // SRL
            4'b0111: opr_res = $signed(opr_a) >>> opr_b[4:0];     // SRA
            4'b1000: opr_res = opr_a | opr_b;                     // OR
            4'b1001: opr_res = opr_a & opr_b;                     // AND
            4'b1010: opr_res = opr_b <<12;                             // LUI: Passes immediate to upper bits
            4'b1011: opr_res = opr_a * opr_b;                     // mul
            4'b1101: opr_res = opr_a + (opr_b << 12);             // AUIPC: Add immediate to PC
            default: opr_res = 32'b0;                             //Default case
        endcase     
    end
    initial begin
        $monitor("Time: %0t | opr_a: %b | opr_b: %b | aluop: %b | opr_res: %b",
                 $time, opr_a, opr_b, aluop, opr_res);
    end
endmodule