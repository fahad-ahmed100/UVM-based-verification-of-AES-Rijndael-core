`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 09:46:31 AM
// Design Name: 
// Module Name: BS
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BS(
input logic [31:0] state_i [3:0],   // State Input
input logic enc_dec,                // Encryption/Decryption Selector
output logic [31:0] state_o [3:0]  // Output State
);

// Calling ByteSub Module for each byte
ByteSub b1 (.A(state_i [0][7:0]),.enc_dec(enc_dec),.B(state_o [0][7:0]));       // B11
ByteSub b2 (.A(state_i [0][15:8]),.enc_dec(enc_dec),.B(state_o [0][15:8]));     // B21 
ByteSub b3 (.A(state_i [0][23:16]),.enc_dec(enc_dec),.B(state_o [0][23:16]));   // B31
ByteSub b4 (.A(state_i [0][31:24]),.enc_dec(enc_dec),.B(state_o [0][31:24]));   // B41
ByteSub b5 (.A(state_i [1][7:0]),.enc_dec(enc_dec),.B(state_o [1][7:0]));       // B12
ByteSub b6 (.A(state_i [1][15:8]),.enc_dec(enc_dec),.B(state_o [1][15:8]));     // B22
ByteSub b7 (.A(state_i [1][23:16]),.enc_dec(enc_dec),.B(state_o [1][23:16]));   // B32
ByteSub b8 (.A(state_i [1][31:24]),.enc_dec(enc_dec),.B(state_o [1][31:24]));   // B42
ByteSub b9 (.A(state_i [2][7:0]),.enc_dec(enc_dec),.B(state_o [2][7:0]));       // B13
ByteSub b10 (.A(state_i [2][15:8]),.enc_dec(enc_dec),.B(state_o [2][15:8]));    // B23
ByteSub b11 (.A(state_i [2][23:16]),.enc_dec(enc_dec),.B(state_o [2][23:16]));  // B33
ByteSub b12 (.A(state_i [2][31:24]),.enc_dec(enc_dec),.B(state_o [2][31:24]));  // B43
ByteSub b13 (.A(state_i [3][7:0]),.enc_dec(enc_dec),.B(state_o [3][7:0]));      // B14
ByteSub b14 (.A(state_i [3][15:8]),.enc_dec(enc_dec),.B(state_o [3][15:8]));    // B24
ByteSub b15 (.A(state_i [3][23:16]),.enc_dec(enc_dec),.B(state_o [3][23:16]));  // B34
ByteSub b16 (.A(state_i [3][31:24]),.enc_dec(enc_dec),.B(state_o [3][31:24]));  // B44

endmodule