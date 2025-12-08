`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 12:06:06 PM
// Design Name: 
// Module Name: ARK
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


module ARK(
input logic [31:0] state_i [3:0], Rk [3:0], // State Input and Round Key
output logic [31:0] state_o [3:0]           // State Output
    );
    
    // Bitwise XOR between each row of Round Key and State
    assign state_o[0] = state_i[0] ^ Rk[0]; // Row1
    assign state_o[1] = state_i[1] ^ Rk[1]; // Row2
    assign state_o[2] = state_i[2] ^ Rk[2]; // Row3
    assign state_o[3] = state_i[3] ^ Rk[3]; // Row4
    
endmodule
