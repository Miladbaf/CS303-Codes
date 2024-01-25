module CLA_16bit_tb();

reg  [15:0]         A, B; // Inputs
reg                 mode;  // mode (add or subtract)
wire [15:0]         S; // result
wire                Ovf;   // Outputs are wires.
wire                Cout;

CLA_16bit_top dut(A, B, mode, S, Cout ,Ovf); // Our design-under-test.

initial begin
    //  * Our waveform is saved under this file.
    
    $dumpfile("CLA_16bit_top.vcd"); 
    
    // * Get the variables from the module.

    $dumpvars(0,CLA_16bit_tb);

    $display("Simulation started.");

    // ADDITION CASES

    // no Carry and No Overflow
    A = 16'h0007;  // 7
    B = 16'h0002;  // 2
    mode = 1'd0;   // Addition mode
    #10;           // Wait 10 time units.

    // no Carry with overflow
    A = 16'h7FFF;  // 32767
    B = 16'h0001;  // 1
    mode = 1'd0;   // Addition mode
    #10;           // Wait 10 time units.

    // with Carry no overflow
    A = 16'hFFFE;  // -2
    B = 16'h0002;  // 2
    mode = 1'd0;   // Addition mode
    #10;           // Wait 10 time units.

    // with Carry with overflow
    A = 16'h8000;  // -32768
    B = 16'h8000;  // -32768
    mode = 1'd0;   // Addition mode
    #10;           // Wait 10 time units.

    // SUBSTRACTION CASES

    // no Carry no overflow
    A = 16'h0000;  // 0
    B = 16'h0002;  // 2
    mode = 1'd1;   // Substraction mode
    #10;           // Wait 10 time units.

    // no Carry with overflow
    A = 16'h7FFF;  // 32767
    B = 16'hFFFF;  // -1
    mode = 1'd1;   // Substraction mode
    #10;           // Wait 10 time units.

    // with Carry no overflow
    A = 16'h0009;  // 9
    B = 16'h0002;  // 2
    mode = 1'd1;   // Substraction mode
    #10;           // Wait 10 time units.

    // with Carry with overflow
    A = 16'h8001;  // -32767
    B = 16'h0002;  // 2
    mode = 1'd1;   // Substraction mode
    #10;           // Wait 10 time units.

    $display("Simulation finished.");
    $finish(); // Finish simulation.
end

endmodule