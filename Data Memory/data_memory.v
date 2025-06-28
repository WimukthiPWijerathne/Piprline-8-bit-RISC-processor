module data_memory(
    input clk,
    input mem_read,
    input mem_write,
    input [7:0] address,
    input [7:0] write_data,
    output reg [7:0] read_data
);
    // 256-byte memory
    reg [7:0] mem [0:255];
    
    // Initialize memory
    integer i;
    initial begin
        for(i=0; i<256; i=i+1)
            mem[i] = 8'd0;
    end
    
    // Read operation
    always @(*) begin
        if(mem_read)
            read_data = mem[address];
        else
            read_data = 8'd0;
    end
    
    // Write operation
    always @(posedge clk) begin
        if(mem_write)
            mem[address] <= write_data;
    end
endmodule