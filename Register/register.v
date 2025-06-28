module register_file(
    input clk,
    input reset,
    input reg_write,
    input [2:0] read_reg1,
    input [2:0] read_reg2,
    input [2:0] write_reg,
    input [7:0] write_data,
    output [7:0] read_data1,
    output [7:0] read_data2
);
    // 8 registers (R0-R7)
    reg [7:0] regs [0:7];
    
    // Initialize
    integer i;
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            for(i=0; i<8; i=i+1)
                regs[i] <= 8'd0;
        end
        else if(reg_write && write_reg != 3'd0) begin
            regs[write_reg] <= write_data;
        end
    end
    
    // Read ports
    assign read_data1 = (read_reg1 == 3'd0) ? 8'd0 : regs[read_reg1];
    assign read_data2 = (read_reg2 == 3'd0) ? 8'd0 : regs[read_reg2];
endmodule