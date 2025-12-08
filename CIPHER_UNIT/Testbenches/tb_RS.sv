`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 10:54:22 AM
// Design Name: 
// Module Name: tb_RS
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


module tb_RS(
    );
    logic [31:0] state_i [3:0], state_o [3:0];
    logic enc_dec;
    RS r1(.state_i(state_i),.enc_dec(enc_dec),.state_o(state_o));
    
    initial begin
    state_i [0] = 32'h01234567; state_i [1] = 32'h456789AB; state_i [2] = 32'h89ABCDEF; state_i [3] = 32'hCDEF0123; enc_dec = 1'b0;
    #10 // Cyclic Left Shift
    state_i [0] = 32'h01234567; state_i [1] = 32'h456789AB; state_i [2] = 32'h89ABCDEF; state_i [3] = 32'hCDEF0123; enc_dec = 1'b1; 
    #10 // Cyclic Right Shift
    $stop;
    end
endmodule
