`include "top.v"
module testbench;
    reg clk, reset;
    
    // Instantiate processor
    top processor(
        .clk(clk),
        .reset(reset)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test sequence
    initial begin
        reset = 1;
        #20 reset = 0;
        
        // Run for 20 clock cycles
        #200 $finish;
    end
    
    // Monitor
    initial begin
        $monitor("Time=%0t PC=%h Instr=%h ALU_Result=%h", 
                $time, processor.pc, processor.instruction, processor.alu_result);
    end
    initial
    begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);
    end
endmodule