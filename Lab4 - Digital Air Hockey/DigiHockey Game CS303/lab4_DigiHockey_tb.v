module DigiHockey_tb();

// Do not worry too much about these parameter statements, they are here to ease your work
parameter HP = 5;       // Half period of our clock signal
parameter FP = (2*HP);  // Full period of our clock signal

reg clk, rst, START;
reg [1:0] DIRECTION;
reg [2:0] INIT_Y_POS;

wire [2:0] X_COORD, Y_COORD;

// Our design-under-test is the DigiHockey module
DigiHockey dut(clk, rst, START, DIRECTION, INIT_Y_POS, X_COORD, Y_COORD);

// This always statement automatically cycles between clock high and clock low in HP (Half Period) time. Makes writing test-benches easier.
always #HP clk = ~clk;

initial begin
    $dumpfile("DigiHockey.vcd"); //  * Our waveform is saved under this file.
    $dumpvars(0,DigiHockey_tb); // * Get the variables from the module.
    
    $display("Simulation started.");

    // * Initialize the testbench variables
    clk = 0; // Set clock low (we won't have to write clk = 1 again, thanks to those parameter and always statements we gave you)
    rst = 0;
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;

    rst = 1; // Assert reset
    #FP; // Hold reset for one period
    rst = 0; // Deassert reset
    
	// Test Case 1: Move straight across X-axis
    START = 1;
    DIRECTION = 0;
    INIT_Y_POS = 2; // Start from the middle row
    #FP; // Apply inputs for one full period

    // Wait for a few periods to observe movement
    # (10*FP);

    rst = 1; // Assert reset
    #FP; // Hold reset for one period
    rst = 0; // Deassert reset

    // Test Case 2: Move up and bounce from the top
    START = 1;
    DIRECTION = 1;
    INIT_Y_POS = 1; // Start from near the bottom
    #FP;

    // Wait for a few periods to observe movement
    # (10*FP);

    rst = 1; // Assert reset
    #FP; // Hold reset for one period
    rst = 0; // Deassert reset

    // Test Case 3: Move down and bounce from the bottom
    START = 1;
    DIRECTION = 2;
    INIT_Y_POS = 3; // Start from near the top
    #FP;

    // Wait for a few periods to observe movement
    # (10*FP);

    rst = 1; // Assert reset
    #FP; // Hold reset for one period
    rst = 0; // Deassert reset

    // Test Case 4: Bounce from bottom-right corner
    START = 1;
    DIRECTION = 2; // Move down initially
    INIT_Y_POS = 4; // Start from top-left corner
    #FP;

    // Wait for periods to observe movement and bouncing
    # (10*FP);

    rst = 1; // Assert reset
    #FP; // Hold reset for one period
    rst = 0; // Deassert reset

    // Test Case 5: Bounce from top-right corner
    START = 1;
    DIRECTION = 1; // Move up initially
    INIT_Y_POS = 0; // Start from top-left corner
    #FP;

    // Wait for periods to observe movement and bouncing
    # (10*FP);

    rst = 1; // Assert reset
    #FP; // Hold reset for one period
    rst = 0; // Deassert reset
	
    $display("Simulation finished.");
    $finish(); // Finish simulation.
end

endmodule
