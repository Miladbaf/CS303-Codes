module DigiHockey(input clk, input rst,
                  input START,
                  input [1:0] DIRECTION,
                  input [2:0] INIT_Y_POS,
                  output reg [2:0] X_COORD,
                  output reg [2:0] Y_COORD);

    reg moving;
    reg [1:0] horiz_direction; // 1: right, 2: left
    reg [1:0] vert_direction;  // 0: no vertical move, 1: up, 2: down

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic
            X_COORD <= 3'b000;
            Y_COORD <= 3'b000;
            moving <= 0;
            horiz_direction <= 1; // Start moving to the right
            vert_direction <= 0; // No vertical move
        end else begin
            if (START && !moving) begin
                // Start the movement
                X_COORD <= 3'b000;
                Y_COORD <= INIT_Y_POS;
                moving <= 1;
                horiz_direction <= 1; // Begin moving to the right
                vert_direction <= DIRECTION[1] ? 2 : (DIRECTION[0] ? 1 : 0); // Decode DIRECTION
            end

            if (moving) begin
                // Horizontal movement logic
                if (horiz_direction == 1 && X_COORD != 3'b100)
                    X_COORD <= X_COORD + 1;
                else if (horiz_direction == 2 && X_COORD != 3'b000)
                    X_COORD <= X_COORD - 1;

                // Vertical movement logic
                if (vert_direction == 1 && Y_COORD != 3'b100) // Up and not at top wall
                    Y_COORD <= Y_COORD + 1;
                else if (vert_direction == 2 && Y_COORD != 3'b000) // Down and not at bottom wall
                    Y_COORD <= Y_COORD - 1;

                // Check for horizontal wall bounce
                if (X_COORD == 3'b100 && horiz_direction == 1) begin // Right wall
                    horiz_direction <= 2; // Change direction to left
                    X_COORD <= X_COORD - 1;
                end
                else if (X_COORD == 3'b000 && horiz_direction == 2) begin // Left wall
                    horiz_direction <= 1; // Change direction to right
                    X_COORD <= X_COORD + 1;
                end
                // Check for vertical wall bounce
                if (Y_COORD == 3'b100 && vert_direction == 1) begin // Top wall
                    vert_direction <= 2; // Change direction to down
                    Y_COORD <= Y_COORD - 1;
                end
                else if (Y_COORD == 3'b000 && vert_direction == 2) begin // Bottom wall
                    vert_direction <= 1; // Change direction to up
                    Y_COORD <= Y_COORD + 1;
                end
            end
        end
    end
endmodule
