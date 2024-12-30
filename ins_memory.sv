module inst_mem(
    input logic[31:0] addr,
    output logic[31:0] data
);
    logic [31:0] mem [100];
    
    
    initial
        begin
        $readmemb("instruction_memory", mem);
        end
   
        assign data = mem[addr[31:2]];
    
endmodule