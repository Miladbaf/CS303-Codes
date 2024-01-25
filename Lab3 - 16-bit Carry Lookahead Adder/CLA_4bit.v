module CLA_4bit (
    input [3:0] C,
    input [3:0] D,
    input Cin,
    input mode, // 0 --> addition , 1 --> subtraction          
    output [3:0] RES,
    output Carry
);
    wire [3:0] G, P, D_inv;
    wire [4:1] C_out;

    // Select D or ~D based on the mode
    assign D_inv = (mode == 1'b0) ? D : ~D;

    // Generate (G) and Propagate (P) signals
    assign G[0] = C[0] & D_inv[0];
    assign G[1] = C[1] & D_inv[1];
    assign G[2] = C[2] & D_inv[2];
    assign G[3] = C[3] & D_inv[3];

    assign P[0] = C[0] ^ D_inv[0];
    assign P[1] = C[1] ^ D_inv[1];
    assign P[2] = C[2] ^ D_inv[2];
    assign P[3] = C[3] ^ D_inv[3];

    // Carry calculations for each bit
    assign C_out[1] = G[0] | (P[0] & Cin);
    assign C_out[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);
    assign C_out[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
    assign C_out[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);

    // Result calculation for each bit
    assign RES[0] = C[0] ^ D_inv[0] ^ Cin;
    assign RES[1] = C[1] ^ D_inv[1] ^ C_out[1];
    assign RES[2] = C[2] ^ D_inv[2] ^ C_out[2];
    assign RES[3] = C[3] ^ D_inv[3] ^ C_out[3];

    assign Carry = C_out[4];

endmodule
