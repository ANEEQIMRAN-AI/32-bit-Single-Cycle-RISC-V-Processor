module MuxA2x1(
    input logic  sel_a,
    input logic [31:0] pc_output,
    input logic [31:0] register_value,
    output logic [31:0] opr_a

);
always_comb begin
        if (sel_a) begin
            opr_a = pc_output;         // If sel_a is 1, choose pc_output
        end else begin
            opr_a = register_value;    // If sel_a is 0, choose register_value
        end
    end


endmodule