`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/07 13:06:50
// Design Name:
// Module Name: priencoder8to3
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


module priencoder8to3(
    input in0,
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input in6,
    input in7,
    output grpsel,
    output enout,
    output [2:0] res
    );
    assign res = (in7) ? 3'h7 : 3'hz,
           res = (~in7 & in6) ? 3'h6 : 3'hz,
           res = (~in7 & ~in6 & in5) ? 3'h5 : 3'hz,
           res = (~in7 & ~in6 & ~in5 & in4) ? 3'h4 : 3'hz,
           res = (~in7 & ~in6 & ~in5 & ~in4 & in3) ? 3'h3 : 3'hz,
           res = (~in7 & ~in6 & ~in5 & ~in4 & ~in3 & in2) ? 3'h2 : 3'hz,
           res = (~in7 & ~in6 & ~in5 & ~in4 & ~in3 & ~in2 & in1) ? 3'h1 : 3'hz,
           res = (~in7 & ~in6 & ~in5 & ~in4 & ~in3 & ~in2 & ~in1 & in0) ? 3'h0 : 3'hz,
           res = (~in7 & ~in6 & ~in5 & ~in4 & ~in3 & ~in2 & ~in1 & ~in0) ? 3'h0 : 3'hz;
    assign enout = (~in7 & ~in6 & ~in5 & ~in4 & ~in3 & ~in2 & ~in1 & ~in0) ? 1'h1 : 1'h0;
    assign grpsel = (in7 | in6 | in5 | in4 | in3 | in2 | in1 | in0) ? 1'h1 : 1'h0;
endmodule
