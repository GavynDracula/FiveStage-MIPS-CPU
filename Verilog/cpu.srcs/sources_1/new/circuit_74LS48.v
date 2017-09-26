`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/29 01:50:03
// Design Name: 
// Module Name: circuit_74LS48
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

/*********************************************************************************
    This moudle is used to imitate the function of circuit 74LS48 which is designed
    for transforming the BCD code to 7 segment code.
Parameter Introduction
input:
    x: the BCD code
output:    
    seg: 7 segment of the digital tube
*********************************************************************************/

module circuit_74LS48(
    input [3:0] x,
    output [6:0] seg
    );    
    assign seg[0] = (~x[3] & ~x[2] & ~x[1] & x[0]) | (~x[3] & x[2] & ~x[1] & ~x[0]);
    assign seg[1] = (~x[3] & x[2] & ~x[1] & x[0]) | (~x[3] & x[2] & x[1] & ~x[0]);
    assign seg[2] = (~x[3] & ~x[2] & x[1] & ~x[0]);
    assign seg[3] = (~x[3] & ~x[2] & ~x[1] & x[0]) | (~x[3] & x[2] & ~x[1] & ~x[0]) | (~x[3] & x[2] & x[1] & x[0]);
    assign seg[4] = (~x[3] & ~x[2] & ~x[1] & x[0]) | (~x[3] & ~x[2] & x[1] & x[0]) | (~x[3] & x[2] & ~x[1] & ~x[0]) | (~x[3] & x[2] & ~x[1] & x[0]) | (~x[3] & x[2] & x[1] & x[0]) | (x[3] & ~x[2] & ~x[1] & x[0]);
    assign seg[5] = (~x[3] & ~x[2] & ~x[1] & x[0]) | (~x[3] & ~x[2] & x[1] & ~x[0]) | (~x[3] & ~x[2] & x[1] & x[0]) | (~x[3] & x[2] & x[1] & x[0]);
    assign seg[6] = (~x[3] & ~x[2] & ~x[1] & ~x[0]) | (~x[3] & ~x[2] & ~x[1] & x[0]) | (~x[3] & x[2] & x[1] & x[0]); 
endmodule
