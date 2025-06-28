`include "../Instruction Memory/instruction_memory.v"
`include "../Cntrol Unit/control.v"
`include "../Data Path/datapath.v"
module top(
    input clk,
    input reset
);
    // Control signals
    wire reg_write, mem_to_reg, mem_read, mem_write;
    wire alu_src, reg_dst, branch, jump;
    wire [2:0] alu_op;
    
    // Datapath signals
    wire [7:0] pc, instruction, alu_result;
    wire zero;
    
    // Instruction memory
    instruction_memory imem(
        .pc(pc),
        .instruction(instruction)
    );
    
    // Control unit
    control ctrl(
        .instruction(instruction),
        .reg_write(reg_write),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .branch(branch),
        .jump(jump)
    );
    
    // Datapath
    datapath dp(
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .branch(branch),
        .jump(jump),
        .pc(pc),
        .alu_result(alu_result),
        .zero(zero)
    );
endmodule