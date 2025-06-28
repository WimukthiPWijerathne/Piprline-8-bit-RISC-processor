module alu(
    input [7:0] a, b,
    input [2:0] op,       // 3-bit operation code
    output reg [7:0] out,
    output zero
);
    // Operation codes
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter AND = 3'b010;
    parameter OR  = 3'b011;
    parameter XOR = 3'b100;
    parameter NOT = 3'b101;
    parameter SLT = 3'b110;

    always @(*) begin
        case(op)
            ADD: out = a + b;
            SUB: out = a - b;
            AND: out = a & b;
            OR:  out = a | b;
            XOR: out = a ^ b;
            NOT: out = ~a;
            SLT: out = (a < b) ? 8'd1 : 8'd0;
            default: out = 8'd0;
        endcase
    end
    
    assign zero = (out == 8'd0);
endmodule