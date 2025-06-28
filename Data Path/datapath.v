`include "../Register/register.v"
`include "../ALU/alu.v"
`include "../Data Memory/data_memory.v"
module datapath(
    input clk,
    input reset,
    input [7:0] instruction,
    input [2:0] alu_op,
    input reg_write,
    input mem_to_reg,
    input mem_read,
    input mem_write,
    input alu_src,
    input reg_dst,
    input branch,
    input jump,
    output [7:0] pc,
    output [7:0] alu_result,
    output zero
);
    // Pipeline registers and internal wires
    wire [7:0] pc_next, pc_plus_1, branch_addr, jump_addr;
    wire [7:0] read_data1, read_data2, write_data;
    wire [7:0] sign_ext_imm, alu_b, mem_read_data;
    wire [2:0] write_reg;
    
    // Program counter
    reg [7:0] pc_reg;
    always @(posedge clk or posedge reset) begin
        if(reset)
            pc_reg <= 8'd0;
        else
            pc_reg <= pc_next;
    end
    assign pc = pc_reg;
    
    // PC logic
    assign pc_plus_1 = pc + 8'd1;
    assign branch_addr = pc_plus_1 + sign_ext_imm;
    assign jump_addr = {pc_plus_1[7:5], instruction[4:0]};
    assign pc_next = jump ? jump_addr : 
                    (branch & zero) ? branch_addr : pc_plus_1;
    
    // Register file
    register_file rf(
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_reg1(instruction[4:2]),
        .read_reg2(instruction[2:0]),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    // ALU
    assign sign_ext_imm = {{5{instruction[1]}}, instruction[1:0]};
    assign alu_b = alu_src ? sign_ext_imm : read_data2;
    alu alu_unit(
        .a(read_data1),
        .b(alu_b),
        .op(alu_op),
        .out(alu_result),
        .zero(zero)
    );
    
    // Memory
    data_memory dmem(
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(mem_read_data)
    );
    
    // Writeback mux
    assign write_data = mem_to_reg ? mem_read_data : alu_result;
    assign write_reg = reg_dst ? instruction[4:2] : instruction[1:0];
endmodule