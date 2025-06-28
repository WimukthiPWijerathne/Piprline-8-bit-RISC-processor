// alu.v
module alu (
    input [7:0] a,           // First operand
    input [7:0] b,           // Second operand
    input [1:0] alu_op,      // ALU operation selector
    output reg [7:0] result, // Output of ALU
    output zero              // Zero flag (1 if result == 0)
);

// ALU Operation Codes:
// 00 -> ADD
// 01 -> SUB
// 10 -> AND
// 11 -> OR

always @(*) begin
    case (alu_op)
        2'b00: result = a + b;     // ADD
        2'b01: result = a - b;     // SUB
        2'b10: result = a & b;     // AND (bitwise)
        2'b11: result = a | b;     // OR (bitwise)
        default: result = 8'b00000000;
    endcase
end

// Zero flag is high if result is all 0s
assign zero = (result == 8'b00000000);

endmodule
