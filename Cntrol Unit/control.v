module control(
    input [7:0] instruction,
    output reg reg_write,
    output reg mem_to_reg,
    output reg mem_read,
    output reg mem_write,
    output reg [2:0] alu_op,
    output reg alu_src,
    output reg reg_dst,
    output reg branch,
    output reg jump
);
    // Extract opcode (top 3 bits)
    wire [2:0] opcode = instruction[7:5];
    
    always @(*) begin
        // Default control signals
        reg_write = 0;
        mem_to_reg = 0;
        mem_read = 0;
        mem_write = 0;
        alu_op = 0;
        alu_src = 0;
        reg_dst = 0;
        branch = 0;
        jump = 0;
        
        case(opcode)
            3'b000: begin // R-type
                reg_write = 1;
                reg_dst = 1;
                alu_op = instruction[4:2];
            end
            3'b001: begin // LW
                reg_write = 1;
                mem_to_reg = 1;
                mem_read = 1;
                alu_src = 1;
                alu_op = 3'b000; // ADD
            end
            3'b010: begin // SW
                mem_write = 1;
                alu_src = 1;
                alu_op = 3'b000; // ADD
            end
            3'b011: begin // BEQ
                branch = 1;
                alu_op = 3'b001; // SUB
            end
            3'b100: begin // J
                jump = 1;
            end
            // Add more instructions as needed
        endcase
    end
endmodule