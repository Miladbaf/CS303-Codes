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

integer total_grade;

// This always statement automatically cycles between clock high and clock low in HP (Half Period) time. Makes writing test-benches easier.
always #HP clk = ~clk;

initial begin
    $dumpfile("DigiHockey.vcd"); //  * Our waveform is saved under this file.
    $dumpvars(0,DigiHockey_tb); // * Get the variables from the module.
    
    $display("Simulation started.");

    total_grade = 10;

    // * Initialize the testbench variables
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;
    clk = 0; // Set clock low (we won't have to write clk = 1 again, thanks to those parameter and always statements we gave you)
    rst = 0;

    // 4 test suites and each with 9 test cases each worth 2 points

// Test Suite A

    #FP;
    rst = 1;
    #FP; // Wait a full clock period to pass
    rst = 0;
    START = 1;
    DIRECTION = 0;
    INIT_Y_POS = 3;
    
    
    if (X_COORD == 0) begin
        $display("[OK] TEST A1 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A1 - X_COORD FAILED");
    end
    if (Y_COORD == 0) begin
        $display("[OK] TEST A1 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A1 - Y_COORD FAILED");
    end

    #FP;
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;

    if (X_COORD == 0) begin
        $display("[OK] TEST A2 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A2 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A2 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A2 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST A3 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A3 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A3 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A3 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST A4 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A4 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A4 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A4 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST A5 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A5 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A5 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A5 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 4) begin
        $display("[OK] TEST A6 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A6 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A6 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A6 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST A7 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A7 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A7 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A7 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST A8 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A8 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A8 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A8 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST A9 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A9 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST A9 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST A9 - Y_COORD FAILED");
    end

#FP;

// Test Suite B

    #FP;
    rst = 1;
    #FP; // Wait a full clock period to pass
    rst = 0;
    START = 1;
    DIRECTION = 1;
    INIT_Y_POS = 2;
    
    
    if (X_COORD == 0) begin
        $display("[OK] TEST B1 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B1 - X_COORD FAILED");
    end
    if (Y_COORD == 0) begin
        $display("[OK] TEST B1 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B1 - Y_COORD FAILED");
    end

    #FP;
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;

    if (X_COORD == 0) begin
        $display("[OK] TEST B2 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B2 - X_COORD FAILED");
    end
    if (Y_COORD == 2) begin
        $display("[OK] TEST B2 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B2 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST B3 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B3 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST B3 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B3 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST B4 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B4 - X_COORD FAILED");
    end
    if (Y_COORD == 4) begin
        $display("[OK] TEST B4 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B4 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST B5 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B5 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST B5 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B5 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 4) begin
        $display("[OK] TEST B6 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B6 - X_COORD FAILED");
    end
    if (Y_COORD == 2) begin
        $display("[OK] TEST B6 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B6 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST B7 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B7 - X_COORD FAILED");
    end
    if (Y_COORD == 1) begin
        $display("[OK] TEST B7 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B7 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST B8 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B8 - X_COORD FAILED");
    end
    if (Y_COORD == 0) begin
        $display("[OK] TEST B8 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B8 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST B9 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B9 - X_COORD FAILED");
    end
    if (Y_COORD == 1) begin
        $display("[OK] TEST B9 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST B9 - Y_COORD FAILED");
    end

#FP;

// Test Suite C

    #FP;
    rst = 1;
    #FP; // Wait a full clock period to pass
    rst = 0;
    START = 1;
    DIRECTION = 2;
    INIT_Y_POS = 2;
    
    
    if (X_COORD == 0) begin
        $display("[OK] TEST C1 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C1 - X_COORD FAILED");
    end
    if (Y_COORD == 0) begin
        $display("[OK] TEST C1 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C1 - Y_COORD FAILED");
    end

    #FP;
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;

    if (X_COORD == 0) begin
        $display("[OK] TEST C2 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C2 - X_COORD FAILED");
    end
    if (Y_COORD == 2) begin
        $display("[OK] TEST C2 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C2 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST C3 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C3 - X_COORD FAILED");
    end
    if (Y_COORD == 1) begin
        $display("[OK] TEST C3 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C3 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST C4 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C4 - X_COORD FAILED");
    end
    if (Y_COORD == 0) begin
        $display("[OK] TEST C4 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C4 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST C5 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C5 - X_COORD FAILED");
    end
    if (Y_COORD == 1) begin
        $display("[OK] TEST C5 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C5 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 4) begin
        $display("[OK] TEST C6 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C6 - X_COORD FAILED");
    end
    if (Y_COORD == 2) begin
        $display("[OK] TEST C6 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C6 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST C7 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C7 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST C7 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C7 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST C8 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C8 - X_COORD FAILED");
    end
    if (Y_COORD == 4) begin
        $display("[OK] TEST C8 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C8 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST C9 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C9 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST C9 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST C9 - Y_COORD FAILED");
    end

#FP;

// Test Suite D

    #FP;
    rst = 1;
    #FP; // Wait a full clock period to pass
    rst = 0;
    START = 1;
    DIRECTION = 1;
    INIT_Y_POS = 0;
    
    
    if (X_COORD == 0) begin
        $display("[OK] TEST D1 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D1 - X_COORD FAILED");
    end
    if (Y_COORD == 0) begin
        $display("[OK] TEST D1 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D1 - Y_COORD FAILED");
    end

    #FP;
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;

    if (X_COORD == 0) begin
        $display("[OK] TEST D2 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D2 - X_COORD FAILED");
    end
    if (Y_COORD == 0) begin
        $display("[OK] TEST D2 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D2 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST D3 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D3 - X_COORD FAILED");
    end
    if (Y_COORD == 1) begin
        $display("[OK] TEST D3 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D3 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST D4 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D4 - X_COORD FAILED");
    end
    if (Y_COORD == 2) begin
        $display("[OK] TEST D4 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D4 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST D5 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D5 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST D5 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D5 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 4) begin
        $display("[OK] TEST D6 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D6 - X_COORD FAILED");
    end
    if (Y_COORD == 4) begin
        $display("[OK] TEST D6 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D6 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 3) begin
        $display("[OK] TEST D7 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D7 - X_COORD FAILED");
    end
    if (Y_COORD == 3) begin
        $display("[OK] TEST D7 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D7 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 2) begin
        $display("[OK] TEST D8 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D8 - X_COORD FAILED");
    end
    if (Y_COORD == 2) begin
        $display("[OK] TEST D8 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D8 - Y_COORD FAILED");
    end

#FP;

    if (X_COORD == 1) begin
        $display("[OK] TEST D9 - X_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D9 - X_COORD FAILED");
    end
    if (Y_COORD == 1) begin
        $display("[OK] TEST D9 - Y_COORD PASSED");
        total_grade = total_grade + 1;
    end else begin
        $display("[FAIL] TEST D9 - Y_COORD FAILED");
    end

#FP;

    $display("Total Grade is %d" , total_grade);
    $display("Simulation finished.");
    $finish(); // Finish simulation.
end



endmodule
