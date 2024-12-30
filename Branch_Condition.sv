module branch_condition(
    input logic        branch_type,
    input logic [31:0] data1,
    input logic [31:0] data2,
    input logic [2:0]  func3,
    output logic       branch_taken

);
  always_comb begin
    if (branch_type) begin
      case (func3)
      3'b000: branch_taken = (data1 == data2);  // BEQ: branch if equal
      3'b001: branch_taken = (data1 != data2);  // BNE: branch if not equal
      3'b100: branch_taken = (data1 < data2);  // BLT: branch if less than (signed)
      3'b101: branch_taken = (data1 >= data2);  // BGE: branch if greater than or equal (signed)
      3'b110: branch_taken = ($unsigned(data1) < $unsigned(data2));  // BLTU: branch if less than (unsigned)
      3'b111: branch_taken = ($unsigned(data1) >= $unsigned(data2));  // BGEU: branch if greater than or equal (unsigned)
      default: branch_taken = 0;
    endcase
    end
  end


endmodule