module instruction_memory(
    input [7:0] pc,
    output reg [7:0] instruction
);
    // 256-byte instruction memory
    reg [7:0] mem [0:255];
    
    // Initialize with sample program
    integer i;  // Declare loop variable separately
    
    initial begin
        // Simple program
        mem[0] = 8'b000_01_010; // ADD R1, R2
        mem[1] = 8'b001_10_011; // SUB R2, R3
        mem[2] = 8'b010_01_100; // LW R1, [R4]
        mem[3] = 8'b011_10_101; // SW R2, [R5]
        
        // Initialize rest to NOPs using traditional for loop
        for(i = 4; i < 256; i = i + 1) begin
            mem[i] = 8'b00000000;
        end
    end
    
    // Read instruction
    always @(*)
        instruction = mem[pc];
endmodule