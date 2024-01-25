module hockey_tb();

parameter HP = 5;       // Half period of our clock signal
parameter FP = (2*HP);  // Full period of our clock signal

reg clk, rst, BTN_A, BTN_B;
reg [1:0] DIR_A;
reg [1:0] DIR_B;
reg [2:0] Y_in_A;
reg [2:0] Y_in_B;

wire [2:0] X_COORD, Y_COORD;

// Our design-under-test is the hockey module
hockey dut(clk, rst, BTN_A, BTN_B, DIR_A, DIR_B, Y_in_A, Y_in_B, X_COORD, Y_COORD);

// Automatically cycle clock
always #HP clk = ~clk;

initial begin
    $dumpfile("hockey.vcd");
    $dumpvars(0, hockey_tb);
    $display("Simulation started.");

    clk = 0; 
    rst = 0;
    BTN_A = 0;
    BTN_B = 0;
    DIR_A = 0;
    DIR_B = 0;
    Y_in_A = 0;
    Y_in_B = 0;

    // 1- Reset the Circuit
    #FP rst = 1;
    #FP rst = 0;

    // 2- Player A starts the game
    #HP BTN_A = 1;
    #FP BTN_A = 0;
    #FP #FP #FP;

    // 3- Inputs for Player A and go to SEND_B state
    Y_in_A = 3'b010;  // Example position
    DIR_A = 2'b01;    // Example direction
    BTN_A = 1;
    #FP BTN_A = 0;
    #FP #FP #FP #FP; // Puck travels to Player B

    // 4- Inputs for Player B, wrong position, go to GOAL_A state
    Y_in_B = 3'b011;  // Different from puck's Y position
    BTN_B = 1;
    #FP BTN_B = 0;
    #FP; // Goal scored

    // 5- Check A has 3 goals, go to HIT_B state (score : 1-0)
    #FP #FP #FP;

    // 6- Inputs for Player B and go to SEND_A state
    Y_in_B = 3'b001;  // Example position
    DIR_B = 2'b10;    // Example direction
    BTN_B = 1;
    #FP BTN_B = 0;
    #FP #FP #FP #FP; // Puck travels to Player A

    // 7- Inputs for Player A, correct position, go to SEND_B state
    Y_in_A = 3'b011;  // Same as puck's Y position
    DIR_A = 2'b01;    // Example direction
    BTN_A = 1;
    #FP BTN_A = 0;
    #FP #FP #FP; // Puck travels to Player B

    // 8- Inputs for Player B, correct position, go to SEND_A state
    Y_in_B = 3'b011;  // Same as puck's Y position
    DIR_B = 2'b10;    // Example direction
    BTN_B = 1;
    #FP BTN_B = 0;
    #FP #FP #FP; // Puck travels to Player A

    // 9- Inputs for Player A, wrong position, go to GOAL_B state
    Y_in_A = 3'b010;  // Different from puck's Y position
    BTN_A = 1;
    #FP BTN_A = 0;
    #FP #FP; // Goal scored

    // 10- Check B has 3 goals, go to HIT_A state (score : 1-1)
    #FP #FP #FP;

    // 11- Inputs for Player A, go to SEND_B state
    Y_in_A = 3'b010;  // Example position
    DIR_A = 2'b01;    // Example direction
    BTN_A = 1;
    #FP BTN_A = 0;
    #FP #FP #FP #FP; // Puck travels to Player B

    // 12- Inputs for Player B, wrong position, go to GOAL_A state
    Y_in_B = 3'b011;  // Different from puck's Y position
    BTN_B = 1;
    #FP BTN_B = 0;
    #FP; // Goal scored

    // 13- Check A has 3 goals, go to HIT_B state (score : 2-1)
    #FP #FP #FP;

    // 14- Inputs for Player B, go to SEND_A state
    Y_in_B = 3'b010;  // Example position
    DIR_B = 2'b10;    // Example direction
    BTN_B = 1;
    #FP BTN_B = 0;
    #FP #FP #FP #FP; // Puck travels to Player A

    // 15- Inputs for Player A, correct position, go to SEND_B state
    Y_in_A = 3'b010;  // Same as puck's Y position
    DIR_A = 2'b01;    // Example direction
    BTN_A = 1;
    #FP BTN_A = 0;
    #FP #FP #FP; // Puck travels to Player B

    // 16- Inputs for Player B, correct position, go to SEND_A state
    Y_in_B = 3'b100;  // Same as puck's Y position
    DIR_B = 2'b10;    // Example direction
    BTN_B = 1;
    #FP BTN_B = 0;
    #FP #FP #FP; // Puck travels to Player A

    // 17- Inputs for Player A, correct position, go to SEND_B state
    Y_in_A = 3'b000;  // Same as puck's Y position
    DIR_A = 2'b01;    // Example direction
    BTN_A = 1;
    #FP BTN_A = 0;
    #FP #FP #FP; // Puck travels to Player B

    // 18- Inputs for Player B, wrong position, go to GOAL_A state
    Y_in_B = 3'b011;  // Different from puck's Y position
    BTN_B = 1;
    #FP BTN_B = 0;
    #FP; // Goal scored

    // 19- Check A has 3 goals, go to ENDED state (score : 3-1)
    #FP #FP #FP #FP #FP;

    $display("Simulation finished.");
    $finish(); // Finish simulation.
end

endmodule
