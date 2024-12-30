module data_memory(
    input logic clk,
    input logic [31:0] address,
    input logic [31:0] write_data,
    input logic [2:0] fun3,
    input logic rd_en,
    input logic wd_en,
    output logic [31:0] rdata

);



  logic [31:0] data_mem[40];  // 40 rows of 32-bit words

  // Read operation for Load
 always_comb begin
    if (rd_en) begin
      case (fun3)
        3'b000:  // LB (Load Byte)
        rdata = {{24{data_mem[address][7]}}, data_mem[address][7:0]};  // Sign-extend byte
        3'b001:  // LH (Load Halfword)
        rdata = {{16{data_mem[address][15]}}, data_mem[address][15:0]};  // Sign-extend halfword
        3'b010:  // LW (Load Word)
        rdata = data_mem[address];  // Load full word
        3'b100:  // LBU (Load Byte Unsigned)
        rdata = {24'b0, data_mem[address][7:0]};  // Zero-extend byte
        3'b101:  // LHU (Load Halfword Unsigned)
        rdata = {16'b0, data_mem[address][15:0]};  // Zero-extend halfword
        default: rdata = 32'b0;
      endcase
    end else begin
      rdata = 32'b0;
    end
  end 

    // Write operation for Store
  always_ff @(posedge clk) begin
    if (wd_en) begin
      data_mem[address] <= write_data;
    end
  end


endmodule