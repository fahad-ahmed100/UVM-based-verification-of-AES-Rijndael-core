`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 12:47:42 PM
// Design Name: 
// Module Name: tb_MixColumn
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


module tb_MixColumn(
    );
    logic [31:0] A,B;
    logic enc_dec;
    MixColumn m1(.A(A),.B(B),.enc_dec(enc_dec));
    initial begin
    A = 32'hd4bf5d30; enc_dec = 1'b0;
    #10 // Should give 046681e5
    A = 32'h046681e5; enc_dec = 1'b1;
    #10 // Should give d4bf5d30
    $stop;
    end
endmodule
