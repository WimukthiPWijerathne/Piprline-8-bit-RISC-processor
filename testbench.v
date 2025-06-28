// testbench.v
`timescale 1ns / 1ps

module testbench;

// ALU signals
reg [7:0] a, b;
reg [1:0] alu_op;
wire [7:0] result;
wire zero;

// Register File signals
reg clk;
reg reg_write;
reg [2:0] read_reg1, read_reg2, write_reg;
reg [7:0] write_data;
wire [7:0] read_data1, read_data2;

// Instantiate ALU
alu my_alu (
    .a(a),
    .b(b),
    .alu_op(alu_op),
    .result(result),
    .zero(zero)
);

// Instantiate Register File
register_file my_rf (
    .clk(clk),
    .reg_write(reg_write),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_reg(write_reg),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Clock generator
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Toggle clk every 5 ns
end

// Main test sequence
initial begin
    $display("Starting Testbench...");

    // --- Test Register Write/Read ---
    reg_write = 1;
    write_reg = 3'b010;
    write_data = 8'b10101010;
    #10;

    reg_write = 0;
    read_reg1 = 3'b010;
    #10;
    $display("Register Read Data: %b", read_data1);

    // --- Test ALU ADD ---
    a = 8'd5;
    b = 8'd10;
    alu_op = 2'b00; // ADD
    #10;
    $display("ALU ADD: 5 + 10 = %d (Zero = %b)", result, zero);

    // --- Test ALU SUB (result zero) ---
    a = 8'd15;
    b = 8'd15;
    alu_op = 2'b01; // SUB
    #10;
    $display("ALU SUB: 15 - 15 = %d (Zero = %b)", result, zero);

    // --- Test ALU AND ---
    a = 8'b11001100;
    b = 8'b10101010;
    alu_op = 2'b10; // AND
    #10;
    $display("ALU AND: %b", result);

    // --- Test ALU OR ---
    alu_op = 2'b11; // OR
    #10;
    $display("ALU OR: %b", result);

    $finish;
end

endmodule
