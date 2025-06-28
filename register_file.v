// register_file.v
module register_file (
    input clk,                      // Clock signal
    input reg_write,               // Enable writing
    input [2:0] read_reg1,         // First register to read
    input [2:0] read_reg2,         // Second register to read
    input [2:0] write_reg,         // Register to write to
    input [7:0] write_data,        // Data to write
    output [7:0] read_data1,       // Output from first register
    output [7:0] read_data2        // Output from second register
);

// Declare 8 registers, each 8-bit wide
reg [7:0] reg_array [7:0];

// Read: just assign outputs directly
assign read_data1 = reg_array[read_reg1];
assign read_data2 = reg_array[read_reg2];

// Write: happens only on clock edge if reg_write is 1
always @(posedge clk) begin
    if (reg_write) begin
        reg_array[write_reg] <= write_data;
    end
end

endmodule
