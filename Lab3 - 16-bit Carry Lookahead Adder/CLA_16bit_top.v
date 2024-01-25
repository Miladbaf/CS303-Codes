module CLA_16bit_top (
    input [15:0] A,
    input [15:0] B,
    input mode, // 0 --> addition , 1 --> subtraction
    output [15:0] S,
    output Cout,
    output OVF
);
    wire [3:0] carry_out;
    wire overflow;

    CLA_4bit cla1 (A[3:0], B[3:0], mode, mode, S[3:0], carry_out[0]);
    CLA_4bit cla2 (A[7:4], B[7:4], carry_out[0], mode, S[7:4], carry_out[1]);
    CLA_4bit cla3 (A[11:8], B[11:8], carry_out[1], mode, S[11:8], carry_out[2]);
    CLA_4bit cla4 (A[15:12], B[15:12], carry_out[2], mode, S[15:12], carry_out[3]);

    assign Cout = carry_out[3];
    assign OVF = carry_out[2] ^ carry_out[3]; // Overflow detection

endmodule