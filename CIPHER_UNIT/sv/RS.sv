`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 12:27:53 PM
// Design Name: 
// Module Name: RS
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


module RS(
input logic [31:0] state_i [3:0],   // State Input
input enc_dec,                      // Encryption/Decryption Selector
output logic [31:0] state_o [3:0]  // Output State
    );

    // Shifting Rows for encryption and decryption
    // No Shift
    assign state_o [3][31:24] = state_i [3][31:24]; 
    assign state_o [2][31:24] = state_i [2][31:24];
    assign state_o [1][31:24] = state_i [1][31:24];
    assign state_o [0][31:24] = state_i [0][31:24];
    // Left or Right Shift once
    assign state_o [3][23:16] = enc_dec ? state_i [0][23:16] : state_i [2][23:16] ;
    assign state_o [2][23:16] = enc_dec ? state_i [3][23:16] : state_i [1][23:16] ;
    assign state_o [1][23:16] = enc_dec ? state_i [2][23:16] : state_i [0][23:16] ;
    assign state_o [0][23:16] = enc_dec ? state_i [1][23:16] : state_i [3][23:16] ;
    // Left or Right Shift twice
    assign state_o [3][15:8] = state_i [1][15:8];  
    assign state_o [2][15:8] = state_i [0][15:8];
    assign state_o [1][15:8] = state_i [3][15:8]; 
    assign state_o [0][15:8] = state_i [2][15:8];
    // Left or Right Shift thrice
    assign state_o [3][7:0] = enc_dec ? state_i [2][7:0] : state_i [0][7:0] ;
    assign state_o [2][7:0] = enc_dec ? state_i [1][7:0] : state_i [3][7:0] ;
    assign state_o [1][7:0] = enc_dec ? state_i [0][7:0] : state_i [2][7:0] ;
    assign state_o [0][7:0] = enc_dec ? state_i [3][7:0] : state_i [1][7:0] ;
endmodule