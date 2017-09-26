`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/06 01:17:29
// Design Name:
// Module Name: priencoder
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


module priencoder(
    input in0,
    input in1,
    input in2,
    input in3,
    output grpsel,
    output enout,
    output [1:0] res
    );
    assign res = (in3) ? 2'h3 : 2'hz,
           res = (~in3 & in2) ? 2'h2 : 2'hz,
           res = (~in3 & ~in2 & in1) ? 2'h1 : 2'hz,
           res = (~in3 & ~in2 & ~in1 & in0) ? 2'h0 : 2'hz,
           res = (~in3 & ~in2 & ~in1 & ~in0) ? 2'hx : 2'hz;
    assign enout = (~in3 & ~in2 & ~in1 & ~in0) ? 1'h1 : 1'h0;
    assign grpsel = (in3 | in2 | in1 | in0) ? 1'h1 : 1'h0;
endmodule
