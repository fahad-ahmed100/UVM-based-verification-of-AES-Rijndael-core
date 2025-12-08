`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 02:32:44 PM
// Design Name: 
// Module Name: MC
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


module MC(
input logic [31:0] state_i [3:0],   // State Input
input enc_dec,                      // Encryption/Decryption Selector
output logic [31:0] state_o [3:0]   // Output State

);

MixColumn m1(.A(state_i[3]), .enc_dec(enc_dec), .B(state_o[3])); // Column 1
MixColumn m2(.A(state_i[2]), .enc_dec(enc_dec), .B(state_o[2])); // Column 2
MixColumn m3(.A(state_i[1]), .enc_dec(enc_dec), .B(state_o[1])); // Column 3
MixColumn m4(.A(state_i[0]), .enc_dec(enc_dec), .B(state_o[0])); // Column 4

endmodule