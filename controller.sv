module controller (
    input  logic [6:0] opcode,
    input  logic [2:0] func3,
    input  logic [6:0] func7,
    output logic [3:0] aluop,
    output logic [1:0] wb_en,
    output logic       sel_b,
    output logic       rd_en,
    output logic       wd_en,
    output logic       sel_a,
    output logic       br_type,
    output logic       jump_en,
    output logic       rf_en
);

  always_comb begin
     // Default control signals
    rf_en     = 1'b0;  // Disable register write-back by default
    sel_b     = 1'b0;  // Disable immediate generation by default
    rd_en     = 1'b0;  // Disable memory read by default
    wd_en     = 1'b0;  // Disable memory write by default
    aluop     = 4'b0000;  // Default ALU operation
    wb_en     = 2'b00;  // Default to ALU result for write-back
    sel_a     = 1'b0;
    jump_en   = 1'b0;
    case (opcode)
      7'b0110011:  // R-Type
            begin
        rf_en = 1'b1;
        sel_b = 1'b0;
        unique case (func3)
          3'b000: begin
            unique case (func7)
              7'b0000000: aluop = 4'b0000;  // ADD
              7'b0100000: aluop = 4'b0001;  // SUB
              7'b0000001: aluop = 4'b1011;  //MUL
            endcase
          end
          3'b001: aluop = 4'b0010;  //SLL
          3'b010: aluop = 4'b0011;  //SLT
          3'b011: aluop = 4'b0100;  //SLTU
          3'b100: aluop = 4'b0101;  //XOR
          3'b101: begin
            unique case (func7)
              7'b0000000: aluop = 4'b0110;  //SRL
              7'b0100000: aluop = 4'b0111;  //SRA
            endcase
          end
          3'b110: aluop = 4'b1000;  //OR
          3'b111: aluop = 4'b1001;  //AND
        endcase
      end
      7'b0010011: begin
        rf_en = 1'b1;  //I type
        sel_b = 1'b1;
        unique case (func3)
          3'b000: aluop = 4'b0000;  //ADDI
          3'b010: aluop = 4'b0011;  //SLTI
          3'b011: aluop = 4'b0100;  //SLTIU
          3'b100: aluop = 4'b0101;  //XORI
          3'b110: aluop = 4'b1000;  //ORI
          3'b111: aluop = 4'b1001;  //ANDI
          3'b001: aluop = 4'b0010;  //SLLI
          3'b101: begin
            unique case (func7)
              7'b0000000: aluop = 4'b0110;  //SRLI
              7'b0100000: aluop = 4'b0111;  //SRAI
            endcase
          end
        endcase
      end

      7'b0000011: begin  // Load instructions
        rf_en = 1'b1;  // Enable write-back for load instructions
        rd_en = 1'b1;  // Enable memory read
        wb_en = 2'b01;  // Select data from memory for write-back
        sel_b = 1'b1;
        aluop = 4'b0000;
      end

      7'b0100011: begin  // Store instructions
        rf_en = 1'b0;  // Disable write-back for store instructions
        wd_en = 1'b1;  // Enable memory write
        sel_b = 1'b1;
        aluop = 4'b0000;
      end

      7'b1100011: // branch type 
            begin
        rf_en   = 1'b0;
        sel_b   = 1'b1;
        sel_a   = 1'b1;
        br_type = 1'b1;
        aluop   = 4'b0000;
      end

      7'b0110111: // LUI instructions U- type
            begin
        rf_en = 1'b1;  // Enable write-back for LUI
        sel_b = 1'b1;  // Enable immediate generation
        aluop = 4'b1010;
      end

      7'b0010111: // AUIPC instructions U- type
            begin
        rf_en = 1'b1;  // Enable write-back for AUIPC
        sel_b = 1'b1;  // Enable immediate generation
        sel_a = 1'b1;
        aluop = 4'b1101;
      end

      7'b1101111: // JAL instruction
            begin
        rf_en   = 1'b1;
        sel_b   = 1'b1;
        wb_en   = 2'b10;  // PC + 4
        sel_a   = 1'b1;  // Use PC as opr_a
        jump_en = 1'b1;
        aluop   = 4'b0000;
      end

      7'b1100111: // JALR instruction
            begin
        rf_en   = 1'b1;
        sel_b   = 1'b1;
        wb_en   = 2'b10;  // PC + 4
        jump_en = 1'b1;
        aluop   = 4'b0000;
      end

      default: rf_en = 1'b0;
    endcase
  end
  // initial begin
  //     $monitor("Time: %0t | opcode: %b | func3: %b | func7: %b | aluop: %b", $time, opcode, func3, func7, aluop);
  // end

endmodule
