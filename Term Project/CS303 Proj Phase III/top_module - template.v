`timescale 1ns / 1ps

module top_module(
    input clk,
    input rst,
    
    input BTN_A,
    input BTN_B,
    
    input [1:0] DIR_A,
    input [1:0] DIR_B,
    
    input [2:0] Y_in_A,
    input [2:0] Y_in_B,
   
    output LEDA,
    output LEDB,
    output [4:0] LEDX,
    
    output a_out, b_out, c_out, d_out, e_out, f_out, g_out, p_out,
    output [7:0] an
);

    wire slow_clk; 
    wire [6:0] SSD[7:0];
    wire [2:0] X_COORD;
    wire [2:0] Y_COORD;

    wire debounced_BTN_A;
    wire debounced_BTN_B;
    wire [1:0] debounced_DIR_A;
    wire [1:0] debounced_DIR_B;
    wire [2:0] debounced_Y_in_A;
    wire [2:0] debounced_Y_in_B;

    clk_divider divider(
        .clk_in(clk),
        .rst(rst),
        .divided_clk(slow_clk)
    );

    debouncer debouncer_BTN_A (.clk(clk), .rst(rst), .noisy_in(BTN_A), .clean_out(debounced_BTN_A));
    debouncer debouncer_BTN_B (.clk(clk), .rst(rst), .noisy_in(BTN_B), .clean_out(debounced_BTN_B));

    debouncer debouncer_DIR_A_0 (.clk(clk), .rst(rst), .noisy_in(DIR_A[0]), .clean_out(debounced_DIR_A[0]));
    debouncer debouncer_DIR_A_1 (.clk(clk), .rst(rst), .noisy_in(DIR_A[1]), .clean_out(debounced_DIR_A[1]));
    debouncer debouncer_DIR_B_0 (.clk(clk), .rst(rst), .noisy_in(DIR_B[0]), .clean_out(debounced_DIR_B[0]));
    debouncer debouncer_DIR_B_1 (.clk(clk), .rst(rst), .noisy_in(DIR_B[1]), .clean_out(debounced_DIR_B[1]));

    debouncer debouncer_Y_in_A_0 (.clk(clk), .rst(rst), .noisy_in(Y_in_A[0]), .clean_out(debounced_Y_in_A[0]));
    debouncer debouncer_Y_in_A_1 (.clk(clk), .rst(rst), .noisy_in(Y_in_A[1]), .clean_out(debounced_Y_in_A[1]));
    debouncer debouncer_Y_in_A_2 (.clk(clk), .rst(rst), .noisy_in(Y_in_A[2]), .clean_out(debounced_Y_in_A[2]));
    debouncer debouncer_Y_in_B_0 (.clk(clk), .rst(rst), .noisy_in(Y_in_B[0]), .clean_out(debounced_Y_in_B[0]));
    debouncer debouncer_Y_in_B_1 (.clk(clk), .rst(rst), .noisy_in(Y_in_B[1]), .clean_out(debounced_Y_in_B[1]));
    debouncer debouncer_Y_in_B_2 (.clk(clk), .rst(rst), .noisy_in(Y_in_B[2]), .clean_out(debounced_Y_in_B[2]));

    hockey hockey_game (
        .clk(slow_clk), // Using the slow clock for game logic
        .rst(rst),
        .BTN_A(debounced_BTN_A),
        .BTN_B(debounced_BTN_B),
        .DIR_A(debounced_DIR_A),
        .DIR_B(debounced_DIR_B),
        .Y_in_A(debounced_Y_in_A),
        .Y_in_B(debounced_Y_in_B),
        .LEDA(LEDA),
        .LEDB(LEDB),
        .LEDX(LEDX),
        .SSD7(SSD[7]),
        .SSD6(SSD[6]),
        .SSD5(SSD[5]),
        .SSD4(SSD[4]),
        .SSD3(SSD[3]),
        .SSD2(SSD[2]),
        .SSD1(SSD[1]),
        .SSD0(SSD[0]),
        .X_COORD(X_COORD),
        .Y_COORD(Y_COORD)
    );

    ssd ssd_driver (
        .clk(clk), // Using the original clock for ssd module
        .rst(rst),
        .SSD7(SSD[7]),
        .SSD6(SSD[6]),
        .SSD5(SSD[5]),
        .SSD4(SSD[4]),
        .SSD3(SSD[3]),
        .SSD2(SSD[2]),
        .SSD1(SSD[1]),
        .SSD0(SSD[0]),
        .a_out(a_out),
        .b_out(b_out),
        .c_out(c_out),
        .d_out(d_out),
        .e_out(e_out),
        .f_out(f_out),
        .g_out(g_out),
        .p_out(p_out),
        .an(an)
    );

endmodule