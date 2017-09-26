`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/06 12:56:21
// Design Name:
// Module Name: DLatch
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


module DLatch(
    input clk,
    input din,
    input rst,
    output reg q
    );

    initial
    begin
        q <= 0;
    end

    always @ (posedge clk)
    begin
        if (rst)
        begin
            q <= 0;
        end
        else
        begin
            q <= din;
        end
    end
endmodule
