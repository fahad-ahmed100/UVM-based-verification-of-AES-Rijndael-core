`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 12:39:10 PM
// Design Name: 
// Module Name: tb_Inv_S_Box
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


module tb_Inv_S_Box(
    );
    logic [7:0] A, B;
    Inv_S_Box i1(.A(A),.B(B));
    integer i,j;
    
    initial begin
    for(i = 0; i<16; i = i + 1) begin
    A[7:4] = i;
    for(j = 0; j<16; j = j + 1) begin
    A[3:0] = j;
    #10
    $write("%h ",B);
    end
    $write("\n");
    end
    $stop;
    end
endmodule
