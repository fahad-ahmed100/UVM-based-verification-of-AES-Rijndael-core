`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 10:16:58 AM
// Design Name: 
// Module Name: tb_ARK
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


module tb_ARK(

    );
logic [31:0] state_i [3:0], Rk [3:0], state_o [3:0];
ARK a1(.state_i(state_i),.Rk(Rk),.state_o(state_o));

initial begin
state_i [0] = 32'h01234567; state_i [1] = 32'h01234567; state_i [2] = 32'h89ABCDEF; state_i [3] = 32'h89ABCDEF;
Rk      [0] = 32'h01234567; Rk      [1] = 32'h01234567; Rk      [2] = 32'h89ABCDEF; Rk      [3] = 32'h89ABCDEF;
#10 // Should output zeroes
state_i [0] = 32'h01234567; state_i [1] = 32'h01234567; state_i [2] = 32'h89ABCDEF; state_i [3] = 32'h89ABCDEF;
Rk      [0] = 32'h89ABCDEF; Rk      [1] = 32'h456789AB; Rk      [2] = 32'h0123CDEF; Rk      [3] = 32'h456789AB;
#10 // Should output non zero numbers
$stop;
end

endmodule
