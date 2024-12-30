module processor (
    input logic clk,
    input logic rst

);
  logic [31:0] pc_out;
  logic [31:0] pc_mout;
  logic [31:0] inst;
  logic [ 6:0] opcode;
  logic [ 2:0] func3;
  logic [ 6:0] func7;
  logic [ 4:0] rs1;
  logic [ 4:0] rs2;
  logic [ 4:0] rd;
  logic [31:0] rdata1;
  logic [31:0] rdata2;
  logic [ 3:0] aluop;
  logic [31:0] opr_a;
  logic [31:0] opr_b;
  logic [31:0] opr_res;
  logic [31:0] extended_imm;
  logic [31:0] extended_load;
  logic [31:0] extended_store;
  logic [31:0] extended_branch;
  logic [31:0] extended_LUI;
  logic [31:0] extended_AUIP;
  logic [31:0] extended_JAL;
  logic [31:0] extended_JALR;
  logic [31:0] Writeback_data;
  logic [31:0] rdata;
  logic [ 1:0] wb_en;
  logic        jump_en;
  logic        sel_a;
  logic        br_type;
  logic        branch_taken;
  logic        rd_en;
  logic        wd_en;
  logic        rf_en;
  logic        sel_b;



  pc pc_inst (
      .clk   (clk),
      .rst   (rst),
      .pc_in (pc_mout),
      .pc_out (pc_out)
  );

  inst_mem imem (
      .addr(pc_out),
      .data(inst)
  );

  inst_dec inst_instance (
      .inst  (inst),
      .rs1   (rs1),
      .rs2   (rs2),
      .rd    (rd),
      .opcode(opcode),
      .func3 (func3),
      .func7 (func7)
  );

  reg_file reg_file_inst (
      .clk(clk),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .rf_en(rf_en),
      .rdata1(rdata1),
      .rdata2(rdata2),
      .wdata(Writeback_data)
  );

  imm_gen immediate_generation (
      .instruction(inst),
      .extended_imm(extended_imm),
      .extended_load(extended_load),
      .extended_store(extended_store),
      .extended_branch(extended_branch),
      .extended_LUI(extended_LUI),
      .extended_AUIP(extended_AUIP),
      .extended_JAL(extended_JAL),
      .extended_JALR(extended_JALR)

  );

  mux mux2X1 (
      .R_type(rdata2),
      .I_type(extended_imm),
      .extended_load(extended_load),
      .extended_store(extended_store),
      .extended_branch(extended_branch),
      .extended_LUI(extended_LUI),
      .extended_AUIP(extended_AUIP),
      .extended_JAL(extended_JAL),
      .extended_JALR(extended_JALR),
      .opcode(opcode),
      .sel_b(sel_b),
      .opr_b(opr_b)


  );

  controller contr_inst (
      .opcode (opcode),
      .func3  (func3),
      .func7  (func7),
      .rf_en  (rf_en),
      .sel_b  (sel_b),
      .rd_en  (rd_en),
      .wd_en  (wd_en),
      .wb_en  (wb_en),
      .br_type(br_type),
      .sel_a  (sel_a),
      .aluop  (aluop),
      .jump_en(jump_en)
  );

  alu alu_inst (
      .opr_a  (opr_a),
      .opr_b  (opr_b),
      .aluop  (aluop),
      .pc_out (pc_out),
      .opr_res(opr_res)
  );

  data_memory data (
      .clk(clk),
      .rd_en(rd_en),
      .wd_en(wd_en),
      .address(opr_res),
      .fun3(func3),
      .rdata(rdata),
      .write_data(rdata2)


  );

  Mux4X1 Mux (
      .w_sel(wb_en),
      .Alu_Res(opr_res),
      .Dat_Res(rdata),
      .pc_out(pc_out),
      .Writeback_data(Writeback_data)

  );

  branch_condition branch (
      .data1(rdata1),
      .data2(rdata2),
      .func3(func3),
      .branch_type(br_type),
      .branch_taken(branch_taken)
  );

  MuxA2x1 MuxA (
      .pc_output(pc_out),
      .register_value(rdata1),
      .sel_a(sel_a),
      .opr_a(opr_a)

  );

  Pc_mux pc_mux (
      .Alu_Result(opr_res),
      .pc_out(pc_out),
      .branch_taken(branch_taken),
      .jump_en(jump_en),
      .pc_mout(pc_mout)

  );

endmodule
