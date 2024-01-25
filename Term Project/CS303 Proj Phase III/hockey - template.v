module hockey(

    input clk,
    input rst,
    
    input BTN_A,
    input BTN_B,
    
    input [1:0] DIR_A,
    input [1:0] DIR_B,
    
    input [2:0] Y_in_A,
    input [2:0] Y_in_B,
   
    output reg LEDA,
    output reg LEDB,
    output reg [4:0] LEDX,
    
    output reg [6:0] SSD7,
    output reg [6:0] SSD6,
    output reg [6:0] SSD5,
    output reg [6:0] SSD4, 
    output reg [6:0] SSD3,
    output reg [6:0] SSD2,
    output reg [6:0] SSD1,
    output reg [6:0] SSD0,
    
    output reg [2:0] X_COORD,
	output reg [2:0] Y_COORD   
    
    );
    
    localparam IDLE = 4'd0,
           DISP = 4'd1,
           HIT_B = 4'd2,
           HIT_A = 4'd3,
           SEND_A = 4'd4,
           SEND_B = 4'd5,
           RESP_A = 4'd6,
           RESP_B = 4'd7,
           GOAL_A = 4'd8,
           GOAL_B = 4'd9,
           ENDED = 4'd10;

    // Game variables
    reg [4:0] game_state;
    reg [6:0] timer;
    reg [2:0] score_A, score_B;
    reg [1:0] current_direction;
    reg turn;

    // Initialize the game state and scores
    initial begin
        game_state <= IDLE;
        timer <= 0;
        score_A <= 0;
        score_B <= 0;
        current_direction <= 0;
        turn <= 0;
    end

    // Main game logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            game_state <= IDLE;
            timer <= 0;
            score_A <= 0;
            score_B <= 0;
            current_direction <= 0;
            turn <= 0;
        end else begin
            case (game_state)
                IDLE: begin
                    if (BTN_A && !BTN_B) begin
                        // BTN_A pressed, BTN_B not pressed
                        turn <= 0;
                        game_state <= DISP;
                    end else if (!BTN_A && BTN_B) begin
                        // BTN_A not pressed, BTN_B pressed
                        turn <= 1;
                        game_state <= DISP;
                    end
                end
                DISP: begin
                    if (timer < 100) begin
                        timer <= timer + 1;
                    end else begin
                        timer <= 0;
                        if (turn == 1) begin
                            game_state <= HIT_B;
                        end else begin
                            game_state <= HIT_A;
                        end
                    end
                end
                HIT_A: begin
                    if (Y_in_A < 5 && BTN_A) begin
                        X_COORD <= 0; // Start from left
                        Y_COORD <= Y_in_A;
                        current_direction <= DIR_A;
                        game_state <= SEND_B;
                    end
                end
                HIT_B: begin
                    if (Y_in_B < 5 && BTN_B) begin
                        X_COORD <= 4; // Start from right
                        Y_COORD <= Y_in_B;
                        current_direction <= DIR_B;
                        game_state <= SEND_A;
                    end
                end
                SEND_A: begin
                    if (timer < 100) begin 
                        timer <= timer + 1;
                    end else begin 
                        timer <= 0;
                    end

                    // Check for bounce and update vertical movement
                    if (current_direction == 2'b01) begin // Moving up
                        if (Y_COORD == 4) begin
                            Y_COORD <= Y_COORD - 1; // Bounce down
                            current_direction <= 2'b10;
                        end    
                        else begin
                            Y_COORD <= Y_COORD + 1;
                        end
                    end else if (current_direction == 2'b10) begin // Moving down
                        if (Y_COORD == 0) begin
                            Y_COORD <= Y_COORD + 1; // Bounce up
                            current_direction <= 2'b01;
                        end 
                        else begin
                            Y_COORD <= Y_COORD - 1;
                        end
                    end
                    if (X_COORD > 1) begin 
                        X_COORD <= X_COORD - 1;
                    end else begin 
                        X_COORD <= 0;
                        game_state <= RESP_A;
                    end
                end
                RESP_A: begin
                    if (timer < 50) begin 
                        if (BTN_A && Y_COORD == Y_in_A) begin
                            X_COORD <= 1;
                            timer <= 0;
                            if (DIR_B == 2'b01) begin // Moving up
                                if (Y_COORD == 4) begin
                                    Y_COORD <= Y_COORD - 1; // Bounce down
                                    current_direction <= 2'b10;
                                    game_state <= SEND_B;
                                end    
                                else begin
                                    Y_COORD <= Y_COORD + 1;
                                    current_direction <= DIR_A;
                                    game_state <= SEND_B;
                                end
                            end else if (DIR_B == 2'b10) begin // Moving down
                                    if (Y_COORD == 0) begin
                                        Y_COORD <= Y_COORD + 1; // Bounce up
                                        current_direction <= 2'b01;
                                        game_state <= SEND_B;
                                    end 
                                    else begin
                                        Y_COORD <= Y_COORD - 1;
                                        current_direction <= DIR_A;
                                        game_state <= SEND_B;
                                    end
                            end else if (DIR_B == 2'b00) begin 
                                current_direction <= DIR_B;
                                game_state <= SEND_B;
                            end
                        end else begin
                            timer <= timer + 1;
                        end
                    end else begin 
                        timer <= 0;
                        score_B <= score_B + 1;
                        game_state <= GOAL_B;
                    end
                end
                SEND_B: begin
                    if (timer < 100) begin 
                        timer <= timer + 1;
                    end else begin 
                        timer <= 0;
                    end

                    // Check for bounce and update vertical movement
                    if (current_direction == 2'b01) begin // Moving up
                        if (Y_COORD == 4) begin
                            Y_COORD <= Y_COORD - 1; // Bounce down
                            current_direction <= 2'b10;
                        end    
                        else begin
                            Y_COORD <= Y_COORD + 1;
                        end
                    end else if (current_direction == 2'b10) begin // Moving down
                        if (Y_COORD == 0) begin
                            Y_COORD <= Y_COORD + 1; // Bounce up
                            current_direction <= 2'b01;
                        end 
                        else begin
                            Y_COORD <= Y_COORD - 1;
                        end
                    end
                    if (X_COORD < 3) begin 
                        X_COORD <= X_COORD + 1;
                    end else begin 
                        X_COORD <= 4;
                        game_state <= RESP_B;
                    end
                end
                RESP_B: begin
                    if (timer < 50) begin 
                        if (Y_in_B == Y_COORD && BTN_B) begin
                            // Transition to Player B's turn
                            X_COORD <= 3;
                            timer <= 0;
                            if (DIR_B == 2'b01) begin // Moving up
                                if (Y_COORD == 4) begin
                                    Y_COORD <= Y_COORD - 1; // Bounce down
                                    current_direction <= 2'b10;
                                    game_state <= SEND_A;
                                end    
                                else begin
                                    Y_COORD <= Y_COORD + 1;
                                    current_direction <= DIR_B;
                                    game_state <= SEND_A;
                                end
                            end else if (DIR_B == 2'b10) begin // Moving down
                                if (Y_COORD == 0) begin
                                    Y_COORD <= Y_COORD + 1; // Bounce up
                                    current_direction <= 2'b01;
                                    game_state <= SEND_A;
                                end 
                                else begin
                                    Y_COORD <= Y_COORD - 1;
                                    current_direction <= DIR_B;
                                    game_state <= SEND_A;
                                end
                            end else if (DIR_B == 2'b00) begin 
                                current_direction <= DIR_A;
                                game_state <= SEND_A;
                            end
                        end else begin
                            timer <= timer + 1;
                        end
                    end else begin 
                        timer <= 0;
                        score_A <= score_A + 1;
                        game_state <= GOAL_A;
                    end
                end
                GOAL_A: begin
                    if (timer < 50) begin 
                        timer <= timer + 1;
                    end else begin 
                        timer <= 0;
                        // Check if A has won
                        if (score_A == 3) begin
                            turn <= 0;
                            game_state <= ENDED;
                        end else begin
                            game_state <= HIT_B;
                        end
                    end
                end
                GOAL_B: begin
                    if (timer < 50) begin 
                        timer <= timer + 1;
                    end else begin 
                        timer <= 0;
                        // Check if B has won
                        if (score_B == 3) begin
                            turn <= 1;
                            game_state <= ENDED;
                        end else begin
                            // No player has won yet, continue the game
                            game_state <= HIT_A;
                        end
                    end
                end
                ENDED: begin
                    if (timer < 50) begin
                        timer <= timer + 1;
                    end
                    else begin
                        timer <= 0;
                    end
                end
                default: begin
                    game_state <= IDLE;
                end
            endcase
        end
    end

    // for LEDs
    always @(posedge clk) begin
        if (rst) begin
            // Reset state
            LEDA <= 0;
            LEDB <= 0;
            LEDX <= 5'b00000;
        end else begin
            case (game_state)
                HIT_A: begin
                    LEDA <= 1;  // Indicate input from Player A
                end
                RESP_A: begin
                    LEDA <= 1;  // Indicate input from Player A
                end
                HIT_B: begin
                    LEDB <= 1;  // Indicate input from Player B
                end
                RESP_B: begin
                    LEDB <= 1;  // Indicate input from Player B
                end
                SEND_A: begin
                    LEDA <= 0;
                    LEDB <= 0;
                    // Update LEDX to show puck movement from right to left
                    LEDX <= 5'b00001 << X_COORD;
                end
                SEND_B: begin
                    LEDA <= 0;
                    LEDB <= 0;
                    // Update LEDX to show puck movement from left to right
                    LEDX <= 5'b10000 >> X_COORD;
                end
                ENDED: begin 
                    LEDX <= 5'b11111;
                end
                default: begin
                    LEDA <= 0;
                    LEDB <= 0;
                    LEDX <= 5'b00000;
                end
            endcase
        end
    end

    // SSD Display Mapping Function
    function [6:0] seven_seg_display;
        input [3:0] value;
        begin
            case(value)
                4'd0: seven_seg_display = 7'b1000000;
                4'd1: seven_seg_display = 7'b1111001;
                4'd2: seven_seg_display = 7'b0100100;
                4'd3: seven_seg_display = 7'b0110000;
                4'd4: seven_seg_display = 7'b0011001;
                4'd5: seven_seg_display = 7'b0010010;
                4'd6: seven_seg_display = 7'b0000010;
                4'd7: seven_seg_display = 7'b1111000;
                4'd8: seven_seg_display = 7'b0000000;
                4'd9: seven_seg_display = 7'b0010000;
                default: seven_seg_display = 7'b1111111; // Blank display
            endcase
        end
    endfunction
    
    //for SSDs
    always @(posedge clk) begin
        if (rst) begin
            // Reset the SSDs if reset is pressed
            SSD7 <= 7'b1111111;
            SSD6 <= 7'b1111111;
            SSD5 <= 7'b1111111;
            SSD4 <= 7'b1111111;
            SSD3 <= 7'b1111111;
            SSD2 <= 7'b1111111;
            SSD1 <= 7'b1111111;
            SSD0 <= 7'b1111111;
        end else begin
            case(game_state)
                DISP: begin
                    SSD2 <= seven_seg_display(score_A); // Display score of A
                    SSD0 <= seven_seg_display(score_B); // Display score of B
                end
                SEND_A: begin
                    SSD5 <= seven_seg_display(Y_COORD); // Display Y-coordinate of the puck
                end
                SEND_B: begin
                    SSD5 <= seven_seg_display(Y_COORD); // Display Y-coordinate of the puck
                end
                GOAL_A: begin
                    SSD2 <= seven_seg_display(score_A); // Display score of A
                    SSD0 <= seven_seg_display(score_B); // Display score of B
                end
                GOAL_B: begin
                    SSD2 <= seven_seg_display(score_A); // Display score of A
                    SSD0 <= seven_seg_display(score_B); // Display score of B
                end
                ENDED: begin
                    SSD2 <= seven_seg_display(score_A); // Display score of A
                    SSD0 <= seven_seg_display(score_B); // Display score of B
                    // Determine winner and display on SSD
                    if (score_A > score_B) begin
                        // Display '1' for Player A wins
                        SSD5 <= seven_seg_display(4'd1);
                    end else if (score_B > score_A) begin
                        // Display '2' for Player B wins
                        SSD5 <= seven_seg_display(4'd2);
                    end
                end
                default: begin
                    // Turn off all displays
                    SSD7 <= 7'b1111111;
                    SSD6 <= 7'b1111111;
                    SSD5 <= 7'b1111111;
                    SSD4 <= 7'b1111111;
                    SSD3 <= 7'b1111111;
                    SSD2 <= 7'b1111111;
                    SSD1 <= 7'b1111111;
                    SSD0 <= 7'b1111111;
                end
            endcase
        end
    end

endmodule